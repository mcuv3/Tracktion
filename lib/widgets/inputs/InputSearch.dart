import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputSearch extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final TextEditingController controller;
  final Function change;
  InputSearch(
      {@required this.textColor,
      @required this.fillColor,
      @required this.change,
      this.controller});

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (val) {
          setState(() {});
          widget.change(val);
        },
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        cursorRadius: Radius.circular(10),
        decoration: InputDecoration(
            suffixIcon: widget.controller.text == ''
                ? null
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      widget.controller.clear();
                    },
                    color: widget.textColor,
                    iconSize: 24,
                  ),
            prefixIcon: Icon(
              Icons.search,
              color: widget.textColor,
              size: 24,
            ),
            fillColor: widget.fillColor,
            filled: true,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.textColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.textColor, width: 1),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    style: BorderStyle.none,
                    color: widget.textColor,
                    width: 10.0)),
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            hintText: ' ... '));
  }
}
