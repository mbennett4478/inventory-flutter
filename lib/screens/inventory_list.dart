import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/add_edit_dialog_provider.dart';
import 'package:inventory/providers/inventory.dart';
import 'package:inventory/widgets/add_edit_dialog.dart';
import 'package:inventory/widgets/inventory_list_view.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<GraphQLClient>(context);

    return ChangeNotifierProvider(
      create: (_) => InventoryProvider(client),
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventories'),
      ),
      body: InventoryListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ChangeNotifierProvider(
                create: (_) => AddEditDialogProvider(inventoryProvider, ModalType.create),
                child: AddEditDialog(),
              );
            }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}