import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/widgets/rounded_button.dart';

class AddEditDialog extends StatelessWidget {
  final ModalType type;
  final Inventory inventory;

  AddEditDialog({
    Key key, 
    this.inventory, 
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderSide = (Color color) => BorderSide(
      color: color,
      width: 0.5,
    );

    TextEditingController textEditingController = TextEditingController(
      text: inventory.name ?? '',
    );

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
              margin: EdgeInsets.only(top: 13.0,right: 8.0),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 30,
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: borderSide(Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Inventory name',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RoundedButton(
                      text: type == ModalType.edit ? 'Edit': 'Create',
                      press: () {},
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
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