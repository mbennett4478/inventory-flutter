import 'package:flutter/material.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/add_edit_dialog_provider.dart';
import 'package:inventory/providers/inventory.dart';
import 'package:inventory/screens/inventory_item_list.dart';
import 'package:inventory/widgets/add_edit_dialog.dart';
import 'package:inventory/widgets/list_item.dart';
import 'package:inventory/widgets/list_item_menu.dart';
import 'package:inventory/widgets/undo_button.dart';
import 'package:provider/provider.dart';

class InventoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(context);

    if (inventoryProvider.loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      child: Stack(
        children: <Widget>[
          ListView.separated(
            itemBuilder: (context, index) {
              return ListItem(
                title: inventoryProvider.inventories[index].name ?? '',
                subtitle: '${inventoryProvider.inventories[index].items.length} items',
                itemIcon: Icons.folder,
                trailing: ListItemMenu(
                  selected: (value) async {
                    switch (value) {
                      case ModalType.edit:
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return ChangeNotifierProvider(
                              create: (_) => AddEditDialogProvider(
                                inventoryProvider, 
                                ModalType.edit, 
                                inventoryProvider.inventories[index]
                              ),
                              child: AddEditDialog(),
                            );
                          },
                        );
                        break;
                      case ModalType.delete:
                        await inventoryProvider.softDelete(index);
                        break;
                    }
                  }
                ),
                onItemPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryItemListView(
                        inventory: inventoryProvider.inventories[index]
                      ),
                    ),
                  );
                },
              );
            }, 
            separatorBuilder: (_, __) => Divider(), 
            itemCount: inventoryProvider.inventories.length,
          ),
          UndoButton(
            visible: inventoryProvider.itemToBeDeleted != null,
            onPress: () => inventoryProvider.undoDelete(),
          ),
        ]
      )
    );
  }
}