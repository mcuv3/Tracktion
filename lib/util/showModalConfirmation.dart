import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';

Future<bool> showModalConfirmation({
  @required BuildContext context,
  @required String contentText,
  String cancelText = 'Cancel',
  String confirmText = 'Ok',
}) {
  return showAnimatedModal<bool>(
      context,
      Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(contentText),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                SizedBox(
                  width: 5,
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
            )
          ],
        ),
      ));
}
