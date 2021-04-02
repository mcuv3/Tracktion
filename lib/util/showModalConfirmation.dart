import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';

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
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.routines)),
                child: Text(
                  cancelText,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.exercise)),
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
