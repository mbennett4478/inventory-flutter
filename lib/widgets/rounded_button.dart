import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color ?? Theme.of(context).colorScheme.primary,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}