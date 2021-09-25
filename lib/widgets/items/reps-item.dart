import 'package:flutter/material.dart';
import 'package:tracktion/widgets/ui/CardInkwell.dart';

class RepItem extends StatelessWidget {
  final bool isExpanded;
  final int reps;
  final double weight;
  final int rpe;
  final bool editable;
  final bool selectable;
  final Widget actions;
  final Function onTap;

  RepItem(
      {@required this.reps,
      @required this.weight,
      @required this.rpe,
      this.onTap,
      this.actions,
      this.selectable = false,
      this.isExpanded = false,
      this.editable = false});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18, color: Colors.black);
    final deviceWidth = MediaQuery.of(context).size.width;
    //TODO: fix this is logic please
    return CardInkwell(
      AnimatedContainer(
        width: selectable
            ? deviceWidth
            : editable
                ? deviceWidth - 40
                : deviceWidth,
        duration: Duration(milliseconds: 200),
        margin: isExpanded ? EdgeInsets.only(bottom: 10) : null,
        padding: EdgeInsets.all(5),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: deviceWidth * 0.2,
                child: FittedBox(
                  fit: reps >= 100 ? BoxFit.contain : BoxFit.none,
                  child: Text("$reps rep(s)", style: textStyle),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                color: Colors.red,
              ),
              Container(
                width: deviceWidth * 0.2,
                child: FittedBox(
                  fit: reps >= 999 ? BoxFit.contain : BoxFit.none,
                  child: Text("$weight kg", style: textStyle),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                color: Colors.red,
              ),
              Container(
                width: deviceWidth * 0.2,
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Text("RPE $rpe", style: textStyle),
                ),
              ),
              if (actions != null) actions
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
