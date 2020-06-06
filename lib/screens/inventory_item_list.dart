import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/providers/inventory.dart';
import 'package:inventory/widgets/list_item.dart';
import 'package:inventory/widgets/list_item_menu.dart';
import 'package:inventory/widgets/undo_button.dart';
import 'package:provider/provider.dart';

class InventoryItemListView extends StatelessWidget {
  final Inventory inventory;

  InventoryItemListView({ Key key, this.inventory }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<GraphQLClient>(context);
    return ChangeNotifierProvider(
      // TODO: Add item provider
      create: (_) => InventoryProvider(client),
      child: Scaffold(
        appBar: AppBar(
          title: Text(inventory.name),
        ),
        body: Body(inventory: inventory),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      // child: Body(inventory: inventory),
    );
  }
}

class Body extends StatelessWidget {
  final Inventory inventory;

  Body({ this.inventory });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.separated(
            itemBuilder: (context, index) {
              return ListItem(
                title: inventory.items[index].item.name,
                subtitle: 'quantity: ${inventory.items[index].quantity}', 
                itemIcon: Icons.local_offer,
                trailing: ListItemMenu(
                  selected: (value) {

                  },
                ),
                onItemPress: () {},
              );
            }, 
            separatorBuilder: (_, __) => Divider(), 
            itemCount: inventory.items.length,
          ),
          UndoButton(
            // TODO: add provider stuff for undo visible
            visible: false,
            // TODO: add undo functionality for provider on undo of item delete
            onPress: null,
          ),
        ],
      ),
    );
  }
}