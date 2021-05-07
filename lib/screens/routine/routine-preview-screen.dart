import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/routine/routine_bloc.dart';
import "package:tracktion/models/db/database.dart";
import 'package:tracktion/widgets/items/RoutineItem.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class RoutinePreview extends StatefulWidget {
  final int routineId;

  const RoutinePreview(this.routineId);

  @override
  _RoutinePreviewState createState() => _RoutinePreviewState();
}

class _RoutinePreviewState extends State<RoutinePreview> {
  List<RoutineSetData> selectedSets = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<RoutineBloc>(context)
          .add(StreamRoutine(widget.routineId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineBloc, RoutineState>(builder: (context, state) {
      if (state is Routine) {
        return StreamBuilder(builder: (context, stream) {
          final List<RoutineSetData> sets = stream.data;

          if (stream.hasData && sets != null) {
            selectedSets = sets;
            Container(
                child: Column(
              children: [
                Text("Routine name"),
                SetsRoutineItem(
                  sets: sets,
                  onDeleteSet: (set) {
                    setState(() {
                      selectedSets.removeWhere((s) => s.id == set.id);
                    });
                  },
                  routineId: widget.routineId,
                  editMode: true,
                ),
                SizedBox(
                  height: 20,
                ),
                SaveFormActions(onCancel: () {}, onSave: () {})
              ],
            ));
          }

          if (stream.hasError)
            return Center(
              child: Text(stream.error),
            );

          return Center(
            child: CircularProgressIndicator(),
          );
        });
      }

      return Text("Loading...");
    });
  }
}
