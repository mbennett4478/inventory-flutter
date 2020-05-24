import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> _inventories = List<Inventory>();
  Inventory _itemToBeDeleted;
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

  void softDelete(int index) {
    if (_itemDeleteTimer != null) {
      _itemDeleteTimer.cancel();
    }

    if (_itemToBeDeleted != null) {
      hardDelete(_itemToBeDeleted.id);
    }
    
    _itemToBeDeleted = _inventories.removeAt(index);
    _itemDeleteTimer = Timer(Duration(seconds: 3), () async {
      await hardDelete(_itemToBeDeleted.id);
      _itemDeleteTimer = null;
      _itemToBeDeleted = null;
      notifyListeners();
    });
    notifyListeners();
  }

  // TODO: add gaphql query and logic to delete inventory
  Future<void> hardDelete(String id) async {
    // QueryResult result = await _client.mutate(
    //   MutationOptions(
    //     documentNode: gql(_removeInventory(id)),
    //   ),
    // ); 
  }

  List<Inventory> get inventories => _inventories;
  bool get loading => _loading;
  Inventory get itemToBeDeleted => _itemToBeDeleted;

  String _getInventories = ''' 
    query GetInventories {
      containers {
        id
        items {
          containerId
          item {
            id
            name
            description
          }
        }
        name
      }
    }
  ''';

  String _removeInventory(String id) {
    return '''
      mutation RemoveInventory {
        deleteContainer(id: "$id") {
          id
        }
      }
    ''';
  }
}