import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

Future<bool> shouldSaveModal(BuildContext context,
        [String message = "Do you want to save your changes?"]) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Discard",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.routines),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.analysis),
                    )),
              ],
            ));
