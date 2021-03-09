import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

Future<bool> shouldSaveModal(BuildContext context, [String message]) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(message == null
                  ? "Do you want to save your changes?"
                  : message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Discard",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.routines),
                    )),
                TextButton(
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
