import 'package:flutter/material.dart';
import "package:tracktion/colors/custom_colors.dart";

enum NotifyType {
  Warning,
  Success,
  Info,
  Danger,
}

class TracktionModalHeader extends StatelessWidget {
  final String title;
  final Color color;
  final Color background;
  const TracktionModalHeader({Key key, this.title, this.color, this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: background),
        child: Text(title, style: TextStyle(fontSize: 18, color: color)));
  }
}

class TracktionNotifyModal extends StatelessWidget {
  final String title;
  final String description;
  final NotifyType type;
  const TracktionNotifyModal({Key key, this.title, this.description, this.type})
      : super(key: key);

  Map<String, Color> getNotifyColors(BuildContext context, NotifyType type) {
    Map<NotifyType, Map<String, Color>> notifyTypeMap = {
      NotifyType.Info: {
        "background": Theme.of(context).colorScheme.analysis,
        "color": Colors.white,
      }
    };
    return notifyTypeMap[type];
  }

  @override
  Widget build(BuildContext context) {
    var colors = getNotifyColors(context, type);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 15,
        ),
        TracktionModalHeader(
            color: colors["color"],
            title: title,
            background: colors["background"]),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, color: colors["background"]),
          ),
        ),
      ],
    );
  }
}
