import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/widgets/rounded_button.dart';

class RoundedDialog extends StatelessWidget {
  final List<Widget> children;
  final String buttonText;
  final VoidCallback onButtonPress;
  final VoidCallback onClose;
  final bool loading;

  RoundedDialog({
    Key key,
    this.children = const <Widget>[],
    this.buttonText,
    this.onButtonPress,
    this.onClose,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 36,
              ),
              margin: EdgeInsets.only(top: 13, right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children + <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RoundedButton(
                      text: buttonText,
                      loading: loading,
                      press: onButtonPress,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: onClose,
                child: Align(
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}