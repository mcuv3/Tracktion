import 'package:flutter/material.dart';
import "package:tracktion/colors/custom_colors.dart";

class IconDetail extends StatelessWidget {
  final Widget icon;
  final String lead;
  final String secondary;

  const IconDetail({Key key, this.icon, this.lead, this.secondary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(style: TextStyle(fontFamily: "CarterOne"), children: [
          WidgetSpan(alignment: PlaceholderAlignment.top, child: icon),
          TextSpan(
              text: " $lead",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.routinesLight,
                  fontWeight: FontWeight.bold)),
          if (secondary != null)
            TextSpan(
                text: " $secondary",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.exercise,
                    fontWeight: FontWeight.w100)),
        ]));
  }
}
