import 'package:flutter/material.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/widgets/list_item_menu.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData itemIcon;

  ListItem({
    Key key,
    this.title,
    this.subtitle,
    this.itemIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Color.fromRGBO(155, 170, 176, 1)),
      ),
      leading: Icon(
        itemIcon,
        color: Color.fromRGBO(155, 170, 176, 1.0),
        size: 30,
      ),
      trailing: ListItemMenu(
        selected: (value) async {
          switch (value) {
            case ModalType.edit:
              // TOOD: edit modal type logic
              break;
            case ModalType.delete:
              // TOOD: delete modal type logic
              break;
          }
        },
      ),
    );
  }
}