import 'package:flutter/material.dart';

class TracktionInput extends StatelessWidget {
  final String initialValue;
  final String hint;
  final int maxlines;
  final String Function(String) validator;
  final Function(String) change;
  final TextEditingController controller;

  TracktionInput(
      {this.initialValue,
      this.hint,
      this.controller,
      this.maxlines = 1,
      this.validator,
       this.change});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        initialValue: initialValue,
        controller: controller,
        maxLines: maxlines,
        onChanged: change,
        onFieldSubmitted: change,
        onSaved: change,
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.black),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0)),
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            hintText: hint));
  }
}
