import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InventoryListView extends StatefulWidget {
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
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
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

          return _inventoriesView(result);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            child: Dialog(
              child: Container(
                width: 200,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              focusColor: Theme.of(context).colorScheme.primary,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
//                              hintText: 'Name your inventory',
//                              hintStyle: TextStyle(
//                                color: Color.fromRGBO(255, 255, 255, 0.5),
//                              ),
                              labelText: 'Name your inventory',
                              labelStyle: TextStyle(
                                color: focusNode.hasFocus ? Colors.red : Theme.of(context).colorScheme.primary,
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
                              print("pressed");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.check, size: 17),
                                Text(
                                    "Create"
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            color: Theme.of(context).colorScheme.error,
//                    padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                            onPressed: () {
                              print("pressed 1");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.clear, size: 17),
                                Text("Cancel"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _inventoriesView(QueryResult result) {
    final inventoryList = result.data['containers'];
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(inventoryList[index]['name'], style: TextStyle(color: Colors.white)),
            subtitle: Text('${inventoryList[index]['items'].length} items', style: TextStyle(color: Color.fromRGBO(155, 170, 176, 1.0))),
            leading: Icon(
              Icons.folder, color: Color.fromRGBO(155, 170, 176, 1.0), size: 30, ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onSelected: (value) {
                print(value);
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
//
//  Widget _addInventoryDialog(BuildContext context) {
//    return
//  }
}