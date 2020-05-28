import 'package:flutter/material.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/add_edit_dialog_provider.dart';
import 'package:inventory/providers/inventory.dart';
import 'package:inventory/widgets/add_edit_dialog.dart';
import 'package:inventory/widgets/list_item_menu.dart';
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
              return ListTile(
                title: Text(
                  inventoryProvider.inventories[index].name ?? '', 
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${inventoryProvider.inventories[index].items.length} items',
                  style: TextStyle(color: Color.fromRGBO(155, 170, 176, 1.0)),
                ),
                leading: Icon(
                  Icons.folder, 
                  color: Color.fromRGBO(155, 170, 176, 1.0),
                  size: 30,
                ),
                trailing: ListItemMenu(
                  selected: (value) async {
                    switch (value) {
                      case ModalType.edit:
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return ChangeNotifierProvider(
                              create: (_) => AddEditDialogProvider(inventoryProvider),
                              child: AddEditDialog(
                                type: ModalType.edit,
                                inventory: inventoryProvider.inventories[index],
                                textEditingController: TextEditingController(text: inventoryProvider.inventories[index].name),
                              ),
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
              );
            }, 
            separatorBuilder: (_, __) => Divider(), 
            itemCount: inventoryProvider.inventories.length,
          ),
          Visibility(
            visible: inventoryProvider.itemToBeDeleted != null,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  left: 60,
                  right: 60,
                  bottom: 20, 
                ),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    inventoryProvider.undoDelete();
                  },
                  icon: Icon(
                    Icons.undo,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Undo delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}