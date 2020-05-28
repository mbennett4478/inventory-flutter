import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/providers/inventory.dart';
import 'package:provider/provider.dart';

class InventoryItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<GraphQLClient>(context);
    return ChangeNotifierProvider(
      // TODO: Add item provider
      create: (_) => InventoryProvider(client),
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}