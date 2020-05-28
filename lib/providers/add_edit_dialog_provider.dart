import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/inventory.dart';

class AddEditDialogProvider extends ChangeNotifier {
  InventoryProvider _inventoryProvider;
  ModalType _type = ModalType.create;
  Inventory _inventory;
  TextEditingController _textEditingController;

  AddEditDialogProvider(InventoryProvider inventoryProvider, ModalType type, [Inventory inventory]) {
    _textEditingController = TextEditingController(text: inventory != null ? inventory.name : '');
    _type = type;
    _inventory = inventory;
    _inventoryProvider = inventoryProvider;
  }

  InventoryProvider get inventoryProvider => _inventoryProvider;
  ModalType get type => _type;
  Inventory get inventory => _inventory;
  TextEditingController get textEditingController => _textEditingController;
}