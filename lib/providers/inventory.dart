import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventories = List<Inventory>();
  GraphQLClient _client;

  InventoryProvider(GraphQLClient client) {
    _client = client;
  }
}