import 'package:flutter/material.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/widgets/ExerciseItem.dart';
import 'package:tracktion/widgets/InputSearch.dart';
import '../colors/custom_colors.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/exercise-search-shape.dart';
import 'package:tracktion/widgets/body-part.dart';
import '../colors/custom_colors.dart';

class SearchExercise extends StatelessWidget {
  final _controller = TextEditingController();
  static const routeName = '/exercise-search';

  void searchHandler(String val) {
    print(val);
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final bodyPart = ModalRoute.of(context).settings.arguments as BodyPart;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          titleSpacing: 0,
          backgroundColor: Colors.white,
          title: Text(bodyPart.toString().split('.')[1],
              style: TextStyle(
                  color: Theme.of(context).colorScheme.exercise, fontSize: 25)),
          centerTitle: true),
      body: Stack(
        children: [
          AbstractShape(
            width: double.infinity,
            height: query.size.height,
            shape: ExerciseSearchShape(Theme.of(context).colorScheme.routines),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: Hero(
                        tag: bodyPart,
                        child: BodyPartWidget(
                          bodyPart,
                          withTitle: false,
                          width: 200,
                          height: 200,
                        )),
                  ),
                  Container(
                    height: query.size.height * 0.47,
                    width: query.size.width * 0.9,
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => ExerciseItem(),
                      itemCount: 26,
                    ),
                  ),
                  Container(
                    width: 350,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: InputSearch(
                        change: searchHandler,
                        controller: _controller,
                        textColor: Colors.white,
                        fillColor: Colors.transparent),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
