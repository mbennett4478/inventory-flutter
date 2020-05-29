import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/inventory.dart';

class AddEditDialogProvider extends ChangeNotifier {
  InventoryProvider _inventoryProvider;
  ModalType _type = ModalType.create;
  Inventory _inventory;
  TextEditingController _textEditingController;
  bool loading = false;

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

  Future<void> createOrEditInventory() async {
    loading = true;
    notifyListeners();
    switch (_type) {
      case ModalType.edit:
        await _inventoryProvider.editInventory(_inventory.id, _textEditingController.text);
        break;
      default:
        await _inventoryProvider.createInventory(_textEditingController.text);
        break;
    }
    loading = false;
    notifyListeners();
  }
}