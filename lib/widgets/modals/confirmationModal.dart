
import 'package:flutter/material.dart';

Future<bool> confirmationModal({BuildContext context, String message}) =>
    showDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          
              content: Text(message),
              actions: [
                FlatButton(
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                FlatButton(
                    child: Text("Yes", style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            ));
