import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Direction {
  left,
  right,
}

class NumericSelector extends StatelessWidget {
  final dynamic value;
  final Function(Direction) onPress;

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
            onPressed: () => onPress(Direction.left)),
        Text(value.toString(), style: const TextStyle(color: Colors.black)),
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14,
            ),
            onPressed: () => onPress(Direction.right)),
      ],
    );
  }
}
