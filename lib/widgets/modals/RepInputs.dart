import 'package:flutter/material.dart';
import 'package:tracktion/models/app/rep.dart';

import '../../colors/custom_colors.dart';

Future<Rep> repInputsModal(BuildContext context, Rep rep) {
  var values = {
    "reps": rep.reps,
    "weight": rep.weight,
    "rpe": rep.rpe,
  };

  return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleRepInput(title: "Reps"),
                    Container(
                      height: 100,
                      child: RepInput(
                        values: values,
                        inputName: "reps",
                      ),
                    ),
                    TitleRepInput(title: "Weight (kg)"),
                    Container(
                      height: 100,
                      child: RepInput(
                        values: values,
                        inputName: "weight",
                        isFloat: true,
                      ),
                    ),
                    TitleRepInput(title: "RPE"),
                    Container(
                      height: 100,
                      child: RepInput(
                        values: values,
                        inputName: "rpe",
                      ),
                    ),
                  ],
                ),
              )
            ],
          )).then((_) => Rep(
      id: rep.id,
      reps: values["reps"] as int,
      weight: values["weight"] as double,
      rpe: values["rpe"] as int,
      notes: rep.notes,
      setId: rep.setId));
}

class TitleRepInput extends StatelessWidget {
  const TitleRepInput({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration:
            BoxDecoration(border: Border.all(width: 0.2, color: Colors.black)),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

class RepInput extends StatefulWidget {
  const RepInput(
      {Key? key,
      required this.values,
      this.isFloat = false,
      required this.inputName})
      : super(key: key);
  final bool isFloat;
  final String inputName;
  final Map<String, num> values;

  @override
  _RepInputState createState() => _RepInputState();
}

class _RepInputState extends State<RepInput> {
  TextEditingController? controller;
  @override
  void initState() {
    controller =
        TextEditingController(text: widget.values[widget.inputName].toString());
    super.initState();
  }

  void changeValueHandler({required String value, num? increment}) {
    final val = widget.isFloat ? double.tryParse(value) : int.tryParse(value);

    var finalValue;
    if (val == null || val < 0) {
      finalValue = widget.isFloat ? 0.0 : 0;
    } else {
      if (increment == null)
        finalValue = val;
      else if (val + increment >= 0)
        finalValue = val + increment;
      else
        finalValue = widget.isFloat ? 0.0 : 0;
      if (isRpe()) {
        finalValue = !isValidRpe(finalValue) ? 10 : finalValue;
      }
    }

    if (controller == null) return;

    setState(() {
      controller!.text = finalValue.toString();
      widget.values[widget.inputName] = finalValue;
    });
  }

  bool isRpe() => widget.inputName == "rpe";
  bool isValidRpe(num val) => val <= 10;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            if (controller != null) return;
            changeValueHandler(
                value: controller!.text, increment: widget.isFloat ? -2.5 : -1);
          },
        ),
      ),
      Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
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
            if (controller != null) return;
            changeValueHandler(
                value: controller!.text, increment: widget.isFloat ? 2.5 : 1);
          },
        ),
      ),
    ]);
  }
}
