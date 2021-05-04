import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/util/enumToString.dart';

class WorkoutRoutinePicker extends StatefulWidget {
  static const routeName = "/workout/routine/picker";
  WorkoutRoutinePicker({Key key}) : super(key: key);

  @override
  _WorkoutRoutinePickerState createState() => _WorkoutRoutinePickerState();
}

class _WorkoutRoutinePickerState extends State<WorkoutRoutinePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cancel,
            ),
            onPressed: () {},
          )
        ],
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 24,
              ),
              hintText: 'eggs ...',
            ),
            onChanged: (value) {},
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Wrap(
                spacing: 0, //vertical spacing
                runSpacing: 0, //horizontal spacing
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: BodyPartEnum.values
                    .map((body) => GestureDetector(
                        onTap: () async {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: true,
                              checkColor: Colors.black,
                              visualDensity: VisualDensity.compact,
                              activeColor: Colors.white,
                              onChanged: (v) {},
                            ),
                            Text(
                              enumToString(body),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (conext, i) => ListTile(
                title: Text("Push #1 - Push Pull Legs Advance"),
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
