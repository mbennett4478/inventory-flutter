import 'package:flutter/material.dart';

class InventoryDeleteSnackbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text('Are you sure you want to delete the inventory?'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
  }
}