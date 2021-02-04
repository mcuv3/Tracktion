import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/exercise-stream/exercisestream_cubit.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/ui/Difficulty.dart';
import 'package:tracktion/widgets/ui/ExerciseWkTitle.dart';

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
