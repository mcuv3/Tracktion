import '../colors/custom_colors.dart';
import 'package:flutter/material.dart';

Future<bool> showModalConfirmation({
  @required BuildContext context,
  @required String contentText,
  String cancelText = 'Cancel',
  String confirmText = 'Ok',
}) {
  return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.all(20),
            content: Text(contentText),
            actions: <Widget>[
              FlatButton(
                color: Theme.of(context).colorScheme.exercise,
                child: Text(
                  cancelText,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                color: Theme.of(context).colorScheme.routines,
                child: Text(
                  confirmText,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ));
}
