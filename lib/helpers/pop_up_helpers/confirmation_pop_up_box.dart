import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';

Future<T?> showConfirmationDialogBox<T>(
  BuildContext context,
  String? confirmationText, {
  required String titleText,
  required Function onConfirm,
  required Function onCancel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(confirmationText ?? ''),
        actions: [
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.pop(context); //* This is for the Dialog Box itself...
            },
            child: Text(AppLocalizations.of(context)!.noText),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context); //* This is for the Dialog Box itself...
            },
            child: Text(AppLocalizations.of(context)!.yesText),
          ),
        ],
      );
    },
  );
}
