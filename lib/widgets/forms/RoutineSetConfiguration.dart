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
  List<RoutineSetData> setsConfigured = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoutineBloc>(context).add(StreamRoutine(widget.routine.id));
  }

  void editHanlder(RoutineSetData set, int idx) async {
    app.Exercise exercise;

    RoutineSetData setRoutine = await showAnimatedModal(
        context,
        SaveSetRoutineForm(
          exercise: exercise,
          routineId: widget.routine.id,
          set: set,
          showMethods: false,
        ));

    setState(() {
      setsConfigured[idx] = setRoutine;
    });
  }

  void submitHanlder() {
    Navigator.of(context).pop(setsConfigured);
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

                if (stream.connectionState == ConnectionState.waiting)
                  return Text("Waiting");

                if (setsConfigured.isEmpty) {
                  setsConfigured = sets;
                }

                return Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: 12),
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
                          onDeleteSet: (r) => editHanlder(r, i),
                          onTapSet: (r) {},
                          set: setsConfigured[i],
                        ),
                        itemCount: setsConfigured.length,
                      ),
                      SaveFormActions(
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          onSave: submitHanlder)
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
