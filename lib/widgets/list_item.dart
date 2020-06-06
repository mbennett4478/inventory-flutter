import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData itemIcon;
  final Widget trailing;
  final VoidCallback onItemPress;

  ListItem({
    Key key,
    this.title,
    this.subtitle,
    this.itemIcon,
    this.trailing,
    this.onItemPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onItemPress ?? null,
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
      trailing: trailing,
    );
  }
}