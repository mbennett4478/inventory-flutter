import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;

  RoundedTextField({
    Key key,
    this.textEditingController,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderSide = (Color color) => BorderSide(
      color: color,
      width: 0.5,
    );

    return TextField(
      controller: textEditingController,    
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration( 
        fillColor: Theme.of(context).colorScheme.primary,
        contentPadding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: borderSide(Theme.of(context).colorScheme.primary),
        ), 
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary, 
        ),
      ),
    );
  }
}