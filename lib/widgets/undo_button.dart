import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onPress;

  UndoButton({ 
    Key key, 
    this.visible = false,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
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
            onPressed: onPress ?? null,
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
    );
  }
}