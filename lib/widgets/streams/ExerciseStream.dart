import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/exercise-stream/exercisestream_cubit.dart';
import 'package:tracktion/colors/constants.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/body-part.dart';

class ExerciseStreamWidget extends StatelessWidget {
  final Function(Exercise) onLoadExercise;

  const ExerciseStreamWidget({Key key, this.onLoadExercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BlocBuilder<ExerciseStreamCubit, ExerciseStreamState>(
          builder: (context, state) {
        if (state is ExeStream) {
          return StreamBuilder(
            stream: state.exe,
            builder: (context, stream) {
              Exercise exs = stream.data;
              if (onLoadExercise != null) onLoadExercise(exs);
              if (stream.connectionState == ConnectionState.active) {
                if (exs == null)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExerciseWorkoutTitle(exs: exs),
                    DifficultyWidget(exs: exs),
                    Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => BodyPartWidget(
                          exs.bodyParts[i],
                          active: true,
                          bgColor: Colors.black,
                        ),
                        itemCount: exs.bodyParts.length,
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }

        return Text("");
      }),
    );
  }
}

class ExerciseWorkoutTitle extends StatelessWidget {
  const ExerciseWorkoutTitle({
    Key key,
    @required this.exs,
  }) : super(key: key);

  final Exercise exs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: shadowList),
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Text(
          exs.name,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

class DifficultyWidget extends StatelessWidget {
  const DifficultyWidget({
    Key key,
    @required this.exs,
  }) : super(key: key);

  final Exercise exs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: shadowList),
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Difficulty : ',
                  style: TextStyle(
                      fontFamily: "CarterOne",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.exercise)),
              TextSpan(
                  text: ' ${enumToString(exs.difficulty)}',
                  style: TextStyle(
                      fontFamily: "CarterOne",
                      color: Theme.of(context).colorScheme.routines)),
            ],
          ),
        ),
      ),
    );
  }
}
