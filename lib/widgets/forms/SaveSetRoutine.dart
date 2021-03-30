import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/tables/Routines.dart';

class SaveSetRoutineForm extends StatefulWidget {
  final Exercise exercise;
  SaveSetRoutineForm({Key key, @required this.exercise}) : super(key: key);

  @override
  _SaveSetRoutineFormState createState() => _SaveSetRoutineFormState();
}

class _SaveSetRoutineFormState extends State<SaveSetRoutineForm> {
  final Map<String, String> copyMethods = {
    "Smart":
        """Base of your prevous workouts with this exercise we provide al list of sets 
    of reps intelligentlly selected for to 
      make progress week by week.""",
    "Static": """
      Provide a number of sets that will be copied every time you select this routine,
      you can provide a RPE target as well.
    """,
    "Previus": """
      Every time you select this routine the most recent and previous set 
      of this exercise  will be copied. 
      """,
    "Percentage": """
      For compund exercise like Squat or Deadlift this option allow you to set a 
      percentage target base of your 1MR(Max Repetition) every time you select this routine it will
      propump with the required value, note that can provide 1MR for flexibility.
    """,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              child: Text(widget.exercise.name,
                  style: TextStyle(
                    fontSize: 18,
                  ))),
          ...ListTile.divideTiles(
              context: context,
              color: Colors.black,
              tiles: CopyMethod.values
                  .map((e) => ListTile(
                        dense: false,
                        contentPadding: EdgeInsets.all(4),
                        leading: Radio(
                          activeColor: Colors.red,
                          value: true,
                          groupValue: "Text",
                          onChanged: (v) {},
                        ),
                        title: Text(e.toString()),
                      ))
                  .toList()),
          TextButton(
            child: Text("Save"),
            onPressed: () {
              Navigator.of(context).pop({"name": "testing"});
            },
          )
        ],
      ),
    );
  }
}
