import 'package:flutter/material.dart';
import 'package:tracktion/models/difficulties.dart';
import 'enumToString.dart';

void showDifficulties({Function cb, BuildContext context}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: Difficulty.values
              .map((i) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    cb(i);
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          enumToString(i),
                          style: TextStyle(fontSize: 18),
                        ),
                        Divider(),
                      ],
                    ),
                  )))
              .toList(),
        ),
      );
    },
  );
}
