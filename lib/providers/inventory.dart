import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> _inventories = List<Inventory>();
  Inventory _itemToBeDeleted;
  int _itemToBeDeletedIndex;
  bool _loading = false;
  GraphQLClient _client;
  Timer _itemDeleteTimer;

  InventoryProvider(GraphQLClient client) {
    _client = client;
    getInventories();
  }

  Future<void> getInventories() async {
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(_getInventories),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );

    _loading = true;
    notifyListeners();

    if (result.data == null) {
      _loading = false;
      notifyListeners();
      return;
    }

    _inventories = result.data['containers'].map<Inventory>((i) => Inventory.fromJson(i)).toList();
    _loading = false;
    notifyListeners();
  }

  Future<void> softDelete(int index) async {
    if (_itemDeleteTimer != null) {
      _itemDeleteTimer.cancel();
    }

    if (_itemToBeDeleted != null) {
      await hardDelete(_itemToBeDeleted.id);
    }
    
    _itemToBeDeleted = _inventories.removeAt(index);
    _itemToBeDeletedIndex = index;
    _itemDeleteTimer =  deleteTimer(_itemToBeDeleted, afterDelete: () {
      _itemToBeDeleted = null;
      _itemDeleteTimer = null;
      _itemToBeDeletedIndex = null;
    });  
    notifyListeners();
  }

  Timer deleteTimer(Inventory i, {Duration duration, VoidCallback afterDelete}) {
    duration = duration ?? Duration(seconds: 3);
    return Timer(duration, () async {
      await hardDelete(i.id);
      if (afterDelete != null) {
        afterDelete();
      }
      await getInventories();
    });
  }

  void undoDelete() {
    _itemDeleteTimer.cancel();
    _itemDeleteTimer = null;
    _inventories.insert(_itemToBeDeletedIndex, _itemToBeDeleted);
    _itemToBeDeleted = null;
    _itemToBeDeletedIndex = null;
    notifyListeners();
  }

  Future<void> hardDelete(String id) async {
    await _client.mutate(
      MutationOptions(
        documentNode: gql(_removeInventory),
        variables: <String, dynamic>{
          'inventoryId': id,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        update: (cache, result) async {
          if (result.hasException) {
            print(result.exception.clientException.message);
          } else {
            final Map<String, Object> updated = Inventory.fromJson(result.data['deleteContainer']).toMap();
            cache.write(typenameDataIdFromObject(updated), updated);
          }
        },
      ),
    ); 
  }

  Future<void> createInventory(String name) async {
    notifyListeners();
    await _client.mutate(
      MutationOptions(
        documentNode: gql(_createInventory),
        variables: <String, dynamic>{
          'name': name,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        update: (cache, result) async {
          if (result.hasException) {
            print(result.exception);
          } else {
            final Map<String, Object> updated = Inventory.fromJson(result.data['createContainer']).toMap();
            cache.write(typenameDataIdFromObject(updated), updated);
          }
        }
      ),
    );
    await getInventories();
  }

  Future<void> editInventory(String id, String name) async {
    notifyListeners();
    await _client.mutate(
      MutationOptions(
        documentNode: gql(_editInventory),
        variables: <String, dynamic>{
          'id': id,
          'container': {
            'name': name,
          },
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        update: (cache, result) async {
          if (result.hasException) {
            print(result.exception);
          } else {
            Inventory temp = Inventory.fromJson(result.data['editContainer']);
            final Map<String, Object> updated = Inventory.fromJson(result.data['editContainer']).toMap();
            cache.write(typenameDataIdFromObject(updated), updated);
            _inventories[_inventories.indexWhere((i) => temp.id == i.id)] = temp;
          }
        }
      ),
    );
    notifyListeners();
  }

  List<Inventory> get inventories => _inventories;
  bool get loading => _loading;
  Inventory get itemToBeDeleted => _itemToBeDeleted;

  String _getInventories = ''' 
    query GetInventories {
      containers {
        __typename
        id
        items {
          __typename
          containerId
          item {
            __typename
            id
            name
            description
          }
        }
        name
      }
    }
  ''';

  String _removeInventory = r'''
    mutation RemoveInventory($inventoryId: ID!) {
      deleteContainer(id: $inventoryId) {
        __typename
        id
        name
        items {
          item {
            id
            name
            description
          }
        }
      }
    }
  ''';

  String _createInventory = r'''
    mutation CreateInventory($name: String!) {
      createContainer(name: $name) {
        __typename
        id
        name
        items {
          __typename
          quantity
          item {
            __typename
            id
            name
            description
          }
        }
      }
    }
  ''';

  String _editInventory = r'''
    mutation EditInventory($id: ID!, $container: UpdatedContainerParams!) {
      editContainer(id: $id, container: $container) {
        __typename
        id
        name
        items {
          __typename
          quantity
          item {
            __typename
            id
            name
            description
          }
        }
      }
    }
  ''';
}
