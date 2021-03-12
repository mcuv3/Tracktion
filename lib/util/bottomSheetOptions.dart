import 'package:flutter/material.dart';

import 'enumToString.dart';

void bottomSheetOptions<T>(
    {required Function cb,
    required BuildContext context,
    required List<T> options}) {
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: options.length,
            itemBuilder: (context, i) => Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      cb(options[i]);
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        enumToString(options[i]),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ));
}
