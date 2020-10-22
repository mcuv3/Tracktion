import 'package:flutter/material.dart';
import 'package:tracktion/models/boyd-parts.dart';
import 'package:tracktion/widgets/body-part.dart';

class ExerciseScreen extends StatelessWidget {
  static const routeName = '/exercise';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('My Exercises',
            style: TextStyle(fontSize: 24, color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.add_box,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8, //vertical spacing
                  runSpacing: 8, //horizontal spacing
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: BodyPart.values
                      .map((bdy) => BodyPartWidget(bdy))
                      .toList(),
                ),
                // Container(
                //   height: 550,
                //   child: GridView.count(

                //     padding: EdgeInsets.all(20),
                //     crossAxisCount: 3,
                //     children: BodyPart.values
                //         .map((bdy) => BodyPartWidget(bdy))
                //         .toList(),
                //     mainAxisSpacing: 6,
                //     crossAxisSpacing: 10,
                //   ),
                // ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
