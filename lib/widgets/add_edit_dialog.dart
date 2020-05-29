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
      loading: dialogProvider.loading,
      buttonText: dialogProvider.type == ModalType.edit ? 'Edit': 'Create',
      onButtonPress: () async {
        await dialogProvider.createOrEditInventory();
        Navigator.of(context).pop();
      },
      onClose: () => Navigator.of(context).pop(),
    );
  }
}