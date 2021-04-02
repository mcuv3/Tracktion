import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumericSelector extends StatelessWidget {
  final dynamic value;
  final Function(String) onPress;

  const NumericSelector({Key key, this.value, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 14,
            ),
            onPressed: () => onPress("left")),
        Text(value.toString()),
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14,
            ),
            onPressed: () => onPress("rigth")),
      ],
    );
  }
}
