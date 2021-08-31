import 'package:flutter/material.dart';
import 'package:tracktion/util/bottomSheetOptions.dart';
import 'package:tracktion/util/enumToString.dart';

class Select<T> extends StatefulWidget {
  Select({Key key, this.value, this.onSelect, this.options}) : super(key: key);

  final Function(T) onSelect;
  final T value;
  final List<T> options;

  @override
  _SelectState<T> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bottomSheetOptions(
            options: widget.options,
            cb: (option) {
              widget.onSelect(option);
              if (!isSelected)
                setState(() {
                  isSelected = true;
                });
            },
            context: context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(enumToString(widget.value),
                  style: TextStyle(
                      color: isSelected
                          ? Colors.black
                          : Colors.black.withOpacity(0.6),
                      fontSize: 16)),
            ),
            Icon(Icons.expand_more)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
