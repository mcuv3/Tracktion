import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/colors/custom_colors.dart';

class RoutineItem extends StatelessWidget {
  final Function onTap;
  RoutineItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.analysis,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Push Day #1",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: FaIcon(FontAwesomeIcons.infoCircle,
                        color: Colors.white),
                    onPressed: () {}),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      style: TextStyle(fontFamily: "CarterOne"),
                      children: <TextSpan>[
                    TextSpan(
                        text: "32",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.routinesLight,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " sets",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.exercise,
                            fontWeight: FontWeight.w100)),
                  ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(fontFamily: "CarterOne"),
                      children: <TextSpan>[
                    TextSpan(
                        text: "6",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.routinesLight,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " exercises",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.exercise,
                            fontWeight: FontWeight.w100)),
                  ])),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(FontAwesomeIcons.trash),
                      onPressed: () {}),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: FaIcon(FontAwesomeIcons.edit),
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
