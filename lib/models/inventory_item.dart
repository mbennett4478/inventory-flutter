import 'item.dart';

class InventoryItem {
  final int quantity;
  final Item item;

  InventoryItem({this.quantity, this.item});

  InventoryItem.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        item = json['item'] ? Item.fromJson(json['item']) : Item();
}