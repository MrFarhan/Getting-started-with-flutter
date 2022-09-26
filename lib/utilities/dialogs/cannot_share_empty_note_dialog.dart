import 'package:flutter/material.dart';
import 'package:myapp/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You can not share empty note!',
    optionsBuilder: () => {'OK': null},
  );
}
