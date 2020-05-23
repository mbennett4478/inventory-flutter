import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> _inventories = List<Inventory>();
  bool _loading = false;
  GraphQLClient _client;

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

    _loading = result.loading;
    notifyListeners();

    if (result.data == null) {
      return;
    }

    _inventories = result.data['containers'].map<Inventory>((i) => Inventory.fromJson(i)).toList();
    notifyListeners();
  }

  Inventory softDelete(int index) {
    Inventory inventoryRemoved = _inventories.removeAt(index);
    notifyListeners();
    return inventoryRemoved;
  }

  // TODO: add gaphql query and logic to delete inventory
  Future<void> hardDelete(String id) async {

  }

  List<Inventory> get inventories => _inventories;
  bool get loading => _loading;

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
}