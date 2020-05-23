import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:provider/provider.dart';

class InventoryListView extends StatefulWidget {
  InventoryListView({Key key}) : super(key: key);
  @override
  _InventoryListView createState() => _InventoryListView();
}

class _InventoryListView extends State<InventoryListView>{
  final String query = ''' 
    query GetInventories {
      containers {
        id
        items {
          containerId
          item {
            id
            name
            description
          }
        }
        name
      }
    }
  ''';

  final inventories = List<Inventory>();

  @override
  Widget build(BuildContext context) {
    final test = Provider.of<GraphQLClient>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventories'),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(query),
        ),
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            return Center(child: Text('No Inventories'));
          }

          return _inventoriesView(result.data['containers'].map<Inventory>((i) => Inventory.fromJson(i)).toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            child: _addEditDialog(ModalType.create, Inventory(), context),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _inventoriesView(List<Inventory> inventoryList) {
//    final inventoryList = result.data['containers'];
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(inventoryList[index].name, style: TextStyle(color: Colors.white)),
            subtitle: Text('${inventoryList[index].items.length} items', style: TextStyle(color: Color.fromRGBO(155, 170, 176, 1.0))),
            leading: Icon(
              Icons.folder, color: Color.fromRGBO(155, 170, 176, 1.0), size: 30, ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: ModalType.edit,
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                PopupMenuItem(
                  value: ModalType.delete,
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case ModalType.edit:
                    showDialog(
                      context: context,
                      child: _addEditDialog(ModalType.edit, inventoryList[index], context),
                    );
                    break;
                  case ModalType.delete:
                    setState(() {
                      inventoryList.removeAt(index);
                    });
                    break;
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Color.fromRGBO(155, 170, 176, 1.0),
                size: 30,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: inventoryList.length,
    );
  }
}

Dialog _addEditDialog(ModalType type, Inventory inventory, BuildContext context) {
  var borderSide = (Color color) => BorderSide(
    color: color,
    width: 0.5,
  );

  var textFieldController = TextEditingController(text: inventory.name ?? '');

  return Dialog(
    child: Container(
      width: 200,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: textFieldController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  enabledBorder: OutlineInputBorder(
                    borderSide: borderSide(Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: borderSide(Theme.of(context).colorScheme.primary),
                  ),
                  labelText: 'Inventory name',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    print('pressed');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.add, size: 17),
                      Text(type == ModalType.edit ? 'Edit': 'Create'),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.clear, size: 17),
                      Text('Cancel'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}