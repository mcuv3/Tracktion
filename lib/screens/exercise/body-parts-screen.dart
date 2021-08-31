import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/bloc/exercise/exercise_bloc.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/screens/workout/exercise-workout-screen.dart';
import 'package:tracktion/widgets/Drawer.dart';
import 'package:tracktion/widgets/body-part.dart';
import 'package:tracktion/widgets/items/ExerciseItem.dart';

import './add-edit-exercise-screen.dart';
import './search-exercise-screen.dart';
import '../../colors/custom_colors.dart';

class BodyPartsScreen extends StatelessWidget {
  static const routeName = '/exercise';

  var searchMode = false;

  List<ExerciseItem> _getExercises(List<Exercise> exes) {
    return exes.map((e) => ExerciseItem(e));
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final readOnly = args != null && args["readOnly"] == true;

    return Scaffold(
        drawer: args != null ? null : MainDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          // automaticallyImplyLeading: false,
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('Body Parts',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          actions: [
            BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) => IconButton(
                onPressed: () async {
                  List<Exercise> exes = [];
                  if (!searchMode) {
                    searchMode = true;
                    BlocProvider.of<ExerciseBloc>(context)
                        .add(FetchAllExercises());
                  }

                  if (state is AllExercises) {
                    exes = state.exes;

                    final exe = await showSearch(
                        context: context,
                        delegate: DataSearch<Exercise>(
                            data: exes,
                            build: (context, exercise) =>
                                ExerciseItem(exercise),
                            onSearch: (query, exe) =>
                                exe.name.toLowerCase().startsWith(query)));

                    searchMode = false;

                    if (exe != null) {
                      Navigator.of(context).pushNamed(ExerciseWorkOut.routeName,
                          arguments: {"exercise": exe});
                    }
                  }
                },
                icon: FaIcon(FontAwesomeIcons.search),
                padding: EdgeInsets.symmetric(horizontal: 25),
              ),
            ),
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
                    children: BodyPartEnum.values
                        .map((body) => GestureDetector(
                            onTap: () async {
                              final exercise = await Navigator.of(context)
                                  .pushNamed(SearchExercise.routeName,
                                      arguments: {
                                    "body": body,
                                    "readOnly": readOnly
                                  });
                              if (readOnly && exercise != null)
                                Navigator.of(context).pop(exercise);
                            },
                            child:
                                Hero(tag: body, child: BodyPartWidget(body))))
                        .toList(),
                  ),
                ],
              ),
            ))
          ],
        )),
        floatingActionButton: readOnly
            ? null
            : Padding(
                padding: EdgeInsets.all(8),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.exercise),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddEditBodyPartsScreen.routeName);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Exercise',
                      style: TextStyle(color: Colors.white)),
                ),
              ));
  }
}

class DataSearch<T> extends SearchDelegate<T> {
  List<T> data = [];
  final bool Function(String, T) onSearch;
  final Widget Function(BuildContext context, T item) build;
  DataSearch({this.data, @required this.onSearch, @required this.build});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.times),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext ctx) {
    final items =
        this.data.where((item) => onSearch(query.toLowerCase(), item)).toList();

    return ListView.builder(
      itemBuilder: (context, i) => GestureDetector(
          onTap: () => close(ctx, data[i]), child: build(context, items[i])),
      itemCount: items.length,
    );
  }
}
