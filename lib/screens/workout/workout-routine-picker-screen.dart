import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/routines/routines_bloc.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/screens/routine/routine-preview-screen.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';

class WorkoutRoutinePicker extends StatefulWidget {
  static const routeName = "/workout/routine/picker";
  WorkoutRoutinePicker({Key key}) : super(key: key);

  @override
  _WorkoutRoutinePickerState createState() => _WorkoutRoutinePickerState();
}

class _WorkoutRoutinePickerState extends State<WorkoutRoutinePicker> {
  final searchController = TextEditingController(text: "");

  final List<bool> filters = BodyPartEnum.values.map((e) => false).toList();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      BlocProvider.of<RoutinesBloc>(context).add(FetchRoutines());
    });
  }

  void showRoutinePreviewHandler(RoutineSlim routine) {
    showAnimatedModal(context, RoutinePreview(routine.id));
  }

  void filterRoutines() {
    BlocProvider.of<RoutinesBloc>(context)
        .add(FilterRoutines(filters, searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.cancel,
            ),
            onPressed: () {
              searchController.text = "";
              filterRoutines();
            },
          )
        ],
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            autofocus: false,
            onChanged: (v) => filterRoutines(),
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 24,
              ),
              hintText: 'Push day ..',
            ),
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
                    .asMap()
                    .entries
                    .map((body) => GestureDetector(
                        onTap: () async {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: filters[body.key],
                              checkColor: Colors.black,
                              visualDensity: VisualDensity.compact,
                              activeColor: Colors.white,
                              focusColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white),
                              onChanged: (v) {
                                filterRoutines();
                                setState(() {
                                  filters[body.key] = v;
                                });
                              },
                            ),
                            Text(
                              enumToString(body.value),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RoutinesBloc, RoutinesState>(
                builder: (context, state) {
              if (state is AllRoutines) {
                final routines = state.filtered;
                print(state.filtered);
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemBuilder: (conext, i) => RoutineSlimWidget(
                    routine: routines[i],
                    key: Key("RoutineWidget $i"),
                    onPress: () {},
                  ),
                  itemCount: routines.length,
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class RoutineSlimWidget extends StatelessWidget {
  final RoutineSlim routine;
  final Function onPress;
  const RoutineSlimWidget({Key key, @required this.routine, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.analysisLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          title: Column(
            children: [
              Text(routine.routineName,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              Text(routine.groupName,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 12)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.gamepad,
                color: Theme.of(context).colorScheme.routines.withOpacity(0.8),
              ),
              Text(enumToString(routine.difficulty),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
