import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';

void showErrorMessage(
    {@required BuildContext context, @required String message}) {
  final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      backgroundColor: Theme.of(context).colorScheme.routines);
  Scaffold.of(context).showSnackBar(snackBar);
}

void showSuccessMessage(
    {@required BuildContext context, @required String message}) {
  final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      backgroundColor: Theme.of(context).colorScheme.analysis);
  Scaffold.of(context).showSnackBar(snackBar);
}
