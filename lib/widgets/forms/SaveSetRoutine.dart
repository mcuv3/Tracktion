import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:tracktion/colors/custom_colors.dart";
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/tables/Routines.dart';
import 'package:tracktion/util/enumToString.dart';
import 'package:tracktion/widgets/inputs/input.dart';
import 'package:tracktion/widgets/modals/showAnimatedModal.dart';
import 'package:tracktion/widgets/ui/Divided.dart';
import 'package:tracktion/widgets/ui/SaveFormActions.dart';

class SaveSetRoutineForm extends StatefulWidget {
  final Exercise exercise;
  SaveSetRoutineForm({Key key, @required this.exercise}) : super(key: key);

  @override
  _SaveSetRoutineFormState createState() => _SaveSetRoutineFormState();
}

class _SaveSetRoutineFormState extends State<SaveSetRoutineForm>
    with TickerProviderStateMixin {
  CopyMethod method = CopyMethod.Previus;
  final controller = TextEditingController(text: "0.0");
  var numSeries = 3;
  var rpe = 8;
  final Map<String, String> copyMethods = {
    "Smart":
        "Base of your prevous workouts with this exercise we provide al list of sets of reps intelligentlly selected for to make progress week by week."
            "",
    "Static":
        "Provide a number of sets that will be copied every time you select this routine, you can provide a RPE target as well.",
    "Previus":
        "Every time you select this routine the most recent and previous set of this exercise  will be copied. ",
    "Percentage":
        "For compund exercise like Squat or Deadlift this option allow you to set a percentage target base of your 1MR(Max Repetition) every time you select this routine it will propump with the required value, note that can provide 1MR for flexibility.",
  };

  void showDetails(CopyMethod copyMethod) {
    showAnimatedModal(
        context,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            buildHeader(enumToString(copyMethod)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                copyMethods[enumToString(copyMethod)],
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ));
  }

  void submit() {
    final mr = double.tryParse(controller.text);

    switch (method) {
      case CopyMethod.Percentage:
        break;
      case CopyMethod.Previus:
        break;
      case CopyMethod.Smart:
        break;
    }
  }

  Widget buildNumericSelector(dynamic value, Function(String) onPress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 14,
            ),
            onPressed: () => onPress("left")),
        Text(value.toString()),
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 14,
            ),
            onPressed: () => onPress("rigth")),
      ],
    );
  }

  Container buildHeader(String text) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.analysis),
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(widget.exercise.name),
          ...ListTile.divideTiles(
              context: context,
              color: Theme.of(context).colorScheme.analysis.withOpacity(0.8),
              tiles: CopyMethod.values
                  .map((e) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(4),
                        leading: Radio(
                          activeColor: Colors.red,
                          value: e,
                          groupValue: method,
                          onChanged: (v) {
                            setState(() {
                              method = v;
                            });
                          },
                        ),
                        title: Text(enumToString(e),
                            style: TextStyle(fontSize: 14)),
                        trailing: IconButton(
                          color: Theme.of(context).colorScheme.analysis,
                          icon: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: Theme.of(context).colorScheme.analysisLight,
                          ),
                          onPressed: () {
                            showDetails(e);
                          },
                        ),
                      ))
                  .toList()),
          buildHeader("Configuration"),
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            child: Container(
              height: method == CopyMethod.Smart || method == CopyMethod.Previus
                  ? 60
                  : 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divided(
                        leftWidget: Text("RPE",
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .exercise
                                    .withOpacity(0.7))),
                        rightWidget:
                            buildNumericSelector(rpe.toString(), (direction) {
                          setState(() {
                            if (rpe < 0 || rpe > 10) return;
                            rpe = direction == "left" ? rpe - 1 : rpe + 1;
                          });
                        })),
                    if (method == CopyMethod.Static)
                      Divided(
                          leftWidget: Text("# Series",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .exercise
                                      .withOpacity(0.7))),
                          rightWidget: buildNumericSelector(
                              numSeries.toString(), (direction) {
                            setState(() {
                              if (numSeries < 0) return;
                              numSeries = direction == "left"
                                  ? numSeries - 1
                                  : numSeries + 1;
                            });
                          })),
                    if (method == CopyMethod.Percentage)
                      Divided(
                          leftWidget: Text("1 MR",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .exercise
                                      .withOpacity(0.7))),
                          rightWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TracktionInput(
                              initialValue: "0.0",
                              keyboardType: TextInputType.number,
                              controller: controller,
                              validator: (v) {
                                final value = double.tryParse(v);
                                if (value == null || value < 0.0)
                                  return "Ivalid number.";

                                return null;
                              },
                              hint: "0.0",
                              align: TextAlign.center,
                            ),
                          )),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ),
          ),
          SaveFormActions(
            onCancel: () {},
            onSave: () {},
          ),
        ],
      ),
    );
  }
}
