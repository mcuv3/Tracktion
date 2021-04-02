import 'package:flutter/material.dart';

Future<dynamic> showAnimatedModal<T>(BuildContext context, Widget widget) {
  return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curverValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
            transform: Matrix4.translationValues(0, curverValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: widget,
            ));
      },
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding: EdgeInsets.all(0),
          content: widget,
        );
      });
}
