import 'package:flutter/material.dart';
import 'package:tracktion/global.dart';
import 'package:tracktion/models/app/rep.dart';
import 'package:tracktion/util/enumToString.dart';

import '../../colors/custom_colors.dart';

class WorkoutRepConfiguration extends StatelessWidget {
  const WorkoutRepConfiguration(this.rep);

  final Rep rep;

  @override
  Widget build(BuildContext context) {
    var values = {
      "reps": rep.reps,
      "weight": TracktionGlobals.of(context).getWeight(rep.weight),
      "rpe": rep.rpe,
    };
    final _metric =
        enumToString(TracktionGlobals.of(context).userPreferencesApp.metric);
    final _defaultIncrement =
        TracktionGlobals.of(context).userPreferencesApp.defaultIncrement;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(Rep(
            id: rep.id,
            reps:
                values["reps"], // return to kg if metric is lbs or otherwise kg
            weight: TracktionGlobals.of(context).getKg(values["weight"]),
            rpe: values["rpe"],
            notes: rep.notes,
            setId: rep.setId));
        return true;
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleRepInput(title: "Reps"),
            Container(
              height: 100,
              child: RepInput(
                values: values,
                inputName: "reps",
                increment: 1,
              ),
            ),
            TitleRepInput(title: "Weight ($_metric)"),
            Container(
              height: 100,
              child: RepInput(
                values: values,
                inputName: "weight",
                increment: _defaultIncrement,
              ),
            ),
            TitleRepInput(title: "RPE"),
            Container(
              height: 100,
              child: RepInput(
                values: values,
                inputName: "rpe",
                increment: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleRepInput extends StatelessWidget {
  const TitleRepInput({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, color: Colors.black),
      ),
    );
  }
}

class RepInput extends StatefulWidget {
  const RepInput(
      {Key key,
      @required this.values,
      @required this.increment,
      @required this.inputName})
      : super(key: key);
  final String inputName;
  final double increment;
  final Map<String, num> values;

  @override
  _RepInputState createState() => _RepInputState();
}

class _RepInputState extends State<RepInput> {
  TextEditingController controller;
  @override
  void initState() {
    controller =
        TextEditingController(text: widget.values[widget.inputName].toString());
    super.initState();
  }

  void changeValueHandler({String value, num increment}) {
    final isDouble = widget.increment is double;
    final val = isDouble ? double.tryParse(value) : int.tryParse(value);

    var finalValue;
    if (val == null || val < 0) {
      finalValue = isDouble ? 0.0 : 0;
    } else {
      if (increment == null)
        finalValue = val;
      else if (val + increment >= 0)
        finalValue = val + increment;
      else
        finalValue = isDouble ? 0.0 : 0;
      if (isRpe()) {
        finalValue = !isValidRpe(finalValue) ? 10 : finalValue;
      }
    }

    setState(() {
      controller.text = finalValue.toString();
      widget.values[widget.inputName] = finalValue;
    });
  }

  bool isRpe() => widget.inputName == "rpe";
  bool isValidRpe(num val) => val <= 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.black),
          child: IconButton(
            color: Colors.black,
            icon: Icon(
              Icons.horizontal_rule,
              color: Colors.white,
            ),
            onPressed: () {
              changeValueHandler(
                  value: controller.text, increment: -1 * widget.increment);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          width: 100,
          height: 60,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: controller,
            onFieldSubmitted: (val) {
              changeValueHandler(value: val);
            },
            showCursor: false,
            cursorColor: Colors.black,
            style: TextStyle(
                color: Theme.of(context).colorScheme.analysis, fontSize: 26),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.black),
          child: IconButton(
            color: Colors.black,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              changeValueHandler(
                  value: controller.text, increment: widget.increment);
            },
          ),
        ),
      ]),
    );
  }
}
