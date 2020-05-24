import 'package:flutter/material.dart';
import 'package:inventory/models/modal_type.dart';

class ListItemMenu extends StatelessWidget {
  final Function selected;

  ListItemMenu({ 
    Key key,
    this.selected, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ModalType.edit,
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem(
          value: ModalType.delete,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onSelected: selected,
      icon: Icon(
        Icons.more_vert,
        color: Color.fromRGBO(155, 170, 176, 1.0),
        size: 30,
      ),
    );
  }
}