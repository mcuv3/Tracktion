import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/routine/routine_bloc.dart';
import 'package:tracktion/colors/custom_colors.dart';
import 'package:tracktion/models/app/RoutineSlim.dart';
import 'package:tracktion/models/app/index.dart' as app;
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/widgets/forms/SaveSetRoutine.dart';
import 'package:tracktion/widgets/items/RoutineItem.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class RoutinesSetConfuguration extends StatefulWidget {
  final RoutineSlim routine;
  RoutinesSetConfuguration({Key key, @required this.routine}) : super(key: key);

  @override
  _RoutinesSetConfugurationState createState() =>
      _RoutinesSetConfugurationState();
}

class _RoutinesSetConfugurationState extends State<RoutinesSetConfuguration> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoutineBloc>(context).add(StreamRoutine(widget.routine.id));
  }

  void editHanlder(RoutineSetData set) async {
    app.Exercise exercise;

    // if (set == null) {
    //   exercise = await Navigator.of(context).pushNamed(
    //       BodyPartsScreen.routeName,
    //       arguments: {"readOnly": true}) as app.Exercise;

    //   if (exercise == null) return;
    // }

    RoutineSetData setRoutine = await showAnimatedModal(
        context,
        SaveSetRoutineForm(
          exercise: exercise,
          routineId: widget.routine.id,
          set: set,
          showMethods: false,
        ));

    // if (setRoutine == null) return;
    print(setRoutine);

    // BlocProvider.of<RoutineBloc>(context).add(SaveSet(setRoutine));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineBloc, RoutineState>(
      builder: (context, state) {
        if (state is Routine) {
          return StreamBuilder(
              stream: state.routine,
              builder: (context, stream) {
                final List<RoutineSetData> sets = stream.data;
                print(sets);
                return Container(
                  margin: EdgeInsets.only(top: 15),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.exercise),
                          child: Text("Configure your sets",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, i) => SetRoutineItem(
                          editMode: true,
                          actionIcon: FontAwesomeIcons.edit,
                          onDeleteSet: (r) => editHanlder(r),
                          onTapSet: (r) {},
                          set: sets[i],
                        ),
                        itemCount: sets.length,
                      ),
                      SaveFormActions(onCancel: () {}, onSave: () {})
                    ],
                  ),
                );
              });
        }

        return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.red));
      },
    );
  }
}
