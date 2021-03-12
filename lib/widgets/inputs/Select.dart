import 'package:flutter/material.dart';
import 'package:tracktion/util/bottomSheetOptions.dart';
import 'package:tracktion/util/enumToString.dart';

class Select<T> extends StatelessWidget {
  const Select(
      {Key? key,
      required this.value,
      required this.onSelect,
      required this.options})
      : super(key: key);

  final Function(T) onSelect;
  final T value;
  final List<T> options;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bottomSheetOptions(
            options: options,
            cb: (option) {
              onSelect(option);
            },
            context: context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black45, width: 1)),
        child: Row(
          children: [
            Text(enumToString(value),
                style: TextStyle(color: Colors.black, fontSize: 16)),
            Icon(Icons.expand_more)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
