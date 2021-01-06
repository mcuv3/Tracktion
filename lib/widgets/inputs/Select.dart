import 'package:flutter/material.dart';
import 'package:tracktion/util/bottomSheetOptions.dart';

class Select extends StatelessWidget {
  const Select(
      {Key key,
      @required this.selection,
      @required this.onSelect,
      @required this.options})
      : super(key: key);

  final Function(dynamic) onSelect;
  final String selection;
  final List<dynamic> options;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bottomSheetOptions(
            options: options,
            cb: (val) {
              onSelect(val);
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
            Text(selection,
                style: TextStyle(color: Colors.black, fontSize: 16)),
            Icon(Icons.expand_more)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
