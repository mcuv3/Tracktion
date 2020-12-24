import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracktion/bloc/workout/workout_bloc.dart';
import 'package:tracktion/screens/data/dummy.dart';
import 'package:tracktion/widgets/DatePicker.dart';
import 'package:tracktion/widgets/reps-item.dart';
import '../../colors/custom_colors.dart';
import 'package:tracktion/widgets/drawer.dart';

import '../index.dart';

class WorkOutScreen extends StatefulWidget {
  static const routeName = "/workout";

  @override
  _WorkOutScreenState createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  int _selectedPage = 0;
  DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime(2020, 11, 28);
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    )..addListener(_updateSelectedPage);
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout(DateTime.now()));

    super.didChangeDependencies();
  }

  void _updateSelectedPage() {
    final closestPage = _pageController.page.round();
    final isClosestPageSelected =
        (_pageController.page - closestPage).abs() < 0.1;
    final selectedPage = isClosestPageSelected ? closestPage : null;
    if (_selectedPage != selectedPage) {
      setState(() {
        _selectedPage = selectedPage;
      });
      // TODO: update the date here as well
    }
  }

  void viewCommentHandler() {}

  void changeDateHandler(bool isRight) {
    final newPage = _selectedPage + (isRight ? 1 : -1);
    _pageController.animateToPage(newPage,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    if (newPage < 0 || newPage == dummy_workouts.length) return;
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month,
          currentDate.day + (isRight ? 1 : -1));
    });
    // BlocProvider.of<WorkoutBloc>(context).add(FetchWorkout(DateTime.now()));
  }

  Widget buildHeader(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ExerciseWorkOut.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Theme.of(context).colorScheme.routines,
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [];
    dummy_workouts[0].forEach((e) {
      items.add({
        "kind": "title",
        "value": e["name"],
      });
      (e["series"] as List<dynamic>).forEach((rep) {
        items.add({
          "kind": "rep",
          "values": {
            "reps": rep["reps"],
            "weight": rep["weight"],
            "rpe": rep["rpe"]
          }
        });
      });
      // items.add({"kind": "items", "value": e["series"]});
      items.add({"kind": "space"});
    });
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: Icon(Icons.info), onPressed: () {}),
            IconButton(icon: Icon(Icons.timer), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(BodyPartsScreen.routeName);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(
            children: [
              DatePicker(
                changeDate: changeDateHandler,
                currentDate: currentDate,
              ),
              Expanded(
                child: BlocBuilder<WorkoutBloc, WorkoutState>(
                  builder: (context, state) {
                    if (state is WorkoutLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is WorkoutSets) {
                      print(state);
                    }

                    return Container(
                      width: double.infinity,
                      child: PageView.builder(
                          controller: _pageController,
                          itemCount: dummy_workouts.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, workout) => Container(
                                width: size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    if (items[i]["kind"] == "title") {
                                      return buildHeader(
                                          context, items[i]["value"]);
                                    }
                                    if (items[i]["kind"] == "rep") {
                                      final rep = items[i]["values"];
                                      return RepItem(
                                        reps: rep["reps"],
                                        weight: rep["weight"],
                                        rpe: rep["rpe"],
                                        onPressComment: viewCommentHandler,
                                      );
                                    }
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: items.length,
                                ),
                              )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
