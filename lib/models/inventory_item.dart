import 'item.dart';

class InventoryItem {
  final int quantity;
  final Item item;
  final String typename;

  InventoryItem({this.quantity, this.item, this.typename});

  InventoryItem.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        item = json['item'] != null ? Item.fromJson(json['item']) : Item(),
        typename = json['__typename'];
  
  Map<String, Object> toMap() {
    return {
      '__typename': typename,
      'quantity': quantity,
      'item': item.toMap(),
    };
  }
}