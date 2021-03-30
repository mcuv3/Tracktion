import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/exercise.dart';
import 'package:tracktion/screens/workout/exercise-workout-screen.dart';
import 'package:tracktion/shapes/AbstractShape.dart';
import 'package:tracktion/shapes/exercise-search-shape.dart';
// import 'package:tracktion/models/database.dart';
import 'package:tracktion/widgets/ErrorMessage.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/inputs/InputSearch.dart';
import 'package:tracktion/widgets/items/ExerciseItem.dart';

import '../../colors/custom_colors.dart';

class SearchExercise extends StatefulWidget {
  static const routeName = '/exercise-search';

  @override
  _SearchExerciseState createState() => _SearchExerciseState();
}

class _SearchExerciseState extends State<SearchExercise> {
  final _controller = TextEditingController();
  var initialization = false;
  var search = '';
  var bodyPart = BodyPartEnum.Arms;
  var readOnly = false;

  void searchHandler(String val) {
    setState(() {
      search = val;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
      bodyPart = args["body"];
      BlocProvider.of<ExerciseBloc>(context).add(FetchExers(bodyPart));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    bodyPart = args["body"] ?? BodyPartEnum.Arms;
    readOnly = args["readOnly"] != null;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          titleSpacing: 0,
          backgroundColor: Colors.white,
          title: Text(bodyPart.toString()?.split('.')[1],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: Hero(
                        tag: bodyPart,
                        child: BodyPartWidget(
                          bodyPart,
                          withTitle: false,
                          width: 150,
                          height: 150,
                        )),
                  ),
                  BlocBuilder<ExerciseBloc, ExerciseState>(
                    builder: (ctx, state) {
                      Widget main;

                      if (state is Exercises) {
                        main = StreamBuilder(
                          builder: (context, exs) {
                            if (exs.connectionState == ConnectionState.active) {
                              List<Exercise> exes = exs.data ?? [];
                              print(exes);
                              exes
                                  .where((ex) => ex.name
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList();

                              return ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (ctx, i) => GestureDetector(
                                    onTap: () {
                                      if (readOnly) {
                                        return Navigator.of(context)
                                            .pop(exes[i]);
                                      }

                                      Navigator.of(context).pushNamed(
                                          ExerciseWorkOut.routeName,
                                          arguments: {"exercise": exes[i]});
                                    },
                                    child: ExerciseItem(exes[i])),
                                itemCount: exes.length,
                              );
                            }

                            return Text('Loading');
                          },
                          stream: state.exes,
                        );
                      }

                      if (state is ExercisesLoading) {
                        main = Center(
                          child: CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.exercise,
                          ),
                        );
                      }

                      if (state is ExerciseFailure) {
                        main = ErrorMessage(
                            primaryColor:
                                Theme.of(context).colorScheme.exercise,
                            secundaryColor:
                                Theme.of(context).colorScheme.exercise,
                            text: state.message);
                      }

                      return Container(
                        height: query.size.height * 0.46,
                        width: query.size.width * 0.9,
                        child: main,
                      );
                    },
                  ),
                  Container(
                    width: 350,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
