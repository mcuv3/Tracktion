import 'package:flutter/material.dart';

class TracktionInput extends StatelessWidget {
  final String initialValue;
  final String hint;
  final int maxlines;
  final String Function(String) validator;
  final Function(String) change;
  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextAlign align;
  final TextInputType keyboardType;

  TracktionInput(
      {this.initialValue,
      this.hint,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.align = TextAlign.start,
      this.maxlines = 1,
      this.validator,
      this.change,
      this.autoFocus = false,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        initialValue: initialValue,
        controller: controller,
        maxLines: maxlines,
        onChanged: change,
        onFieldSubmitted: change,
        autofocus: autoFocus,
        onSaved: change,
        textAlign: align,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            isCollapsed: true,
            errorStyle: TextStyle(color: Colors.black, fontSize: 14),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0)),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            hintText: hint));
  }
}
