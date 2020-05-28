import 'package:inventory/models/inventory_item.dart';

class Inventory {
  final String id;
  final String name;
  final List<InventoryItem> items;
  final String typename;

  Inventory({this.id, this.name, this.items, this.typename});

  Inventory.fromJson(Map<String, dynamic> jsonObj)
      : id = jsonObj['id'],
        name = jsonObj['name'],
        items = jsonObj['items'].map<InventoryItem>((model) => InventoryItem.fromJson(model)).toList(),
        typename = jsonObj['__typename'];

  Map<String, Object> toMap() {
    return {
      '__typename': typename,
      'id': id,
      'name': name,
      'items': items.map<Map<String, Object>>((model) => model.toMap()).toList(),
    };
  }
}

