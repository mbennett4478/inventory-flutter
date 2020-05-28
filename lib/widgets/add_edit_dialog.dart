import 'package:flutter/material.dart';
import 'package:inventory/models/modal_type.dart';
import 'package:inventory/providers/add_edit_dialog_provider.dart';
import 'package:inventory/widgets/rounded_dialog.dart';
import 'package:inventory/widgets/rounded_text_field.dart';
import 'package:provider/provider.dart';

class AddEditDialog extends StatelessWidget {
  AddEditDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialogProvider = Provider.of<AddEditDialogProvider>(context);
    return RoundedDialog(
      children: <Widget>[
        RoundedTextField(
          key: key,
          textEditingController: dialogProvider.textEditingController,
          labelText: 'Inventory name',
        ),
      ],
      buttonText: dialogProvider.type == ModalType.edit ? 'Edit': 'Create',
      onButtonPress: () async {
        switch (dialogProvider.type) {
          case ModalType.edit:
            await dialogProvider.inventoryProvider.editInventory(dialogProvider.inventory.id, dialogProvider.textEditingController.text);
            break;
          default:
            await dialogProvider.inventoryProvider.createInventory(dialogProvider.textEditingController.text);
            break;
        }
      },
      onClose: () => Navigator.of(context).pop(),
    );
  }
}

// class AddEditDialog extends StatelessWidget {
//   final Inventory inventory;
//   final ModalType type;
//   final TextEditingController textEditingController;

//   AddEditDialog({
//     Key key,
//     this.inventory, 
//     this.type,
//     this.textEditingController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var borderSide = (Color color) => BorderSide(
//       color: color,
//       width: 0.5,
//     );

//     final AddEditDialogProvider addEditDialogProvider = Provider.of<AddEditDialogProvider>(context);

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         margin: EdgeInsets.only(left: 0, right: 0),
//         child: Stack(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 18,
//                 vertical: 36,
//               ),
//               margin: EdgeInsets.only(top: 13.0,right: 8.0),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 0,
//                     offset: Offset(0, 0),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   TextField(
//                     controller: textEditingController,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       fillColor: Theme.of(context).colorScheme.primary,
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 30,
//                       ),
//                       border: new OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: borderSide(Theme.of(context).colorScheme.primary),
//                       ),
//                       labelText: 'Inventory name',
//                       labelStyle: TextStyle(
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20),
//                     child: RoundedButton(
//                       text: type == ModalType.edit ? 'Edit': 'Create',
//                       loading: addEditDialogProvider.creating,
//                       press: () async {
//                         await addEditDialogProvider.create(
//                           textEditingController.text,
//                           inventory != null ? inventory.id : null,
//                           type,
//                         );
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 0,
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: CircleAvatar(
//                     radius: 14,
//                     backgroundColor: Theme.of(context).colorScheme.error,
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }