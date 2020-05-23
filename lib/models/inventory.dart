import 'dart:convert';

import 'package:inventory/models/inventory_item.dart';

class Inventory {
  final String id;
  final String name;
  final List<InventoryItem> items;

  Inventory({this.id, this.name, this.items});

  Inventory.fromJson(Map<String, dynamic> jsonObj)
      : id = jsonObj['id'],
        name = jsonObj['name'],
        items = jsonObj['items'].map<InventoryItem>((model) => InventoryItem.fromJson(model)).toList();
}

