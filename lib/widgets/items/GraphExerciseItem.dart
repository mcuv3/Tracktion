import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/models/app/set.dart';
import 'package:tracktion/util/analysis/getSetMaxWeigth.dart';

import '../../util/mapWithIndex.dart';

String getYLabel(double value) {
  // var isCentenary = false;
  // if (value > 100) {
  //   value = value / 100;
  //   isCentenary = true;
  // }

  return value.toInt().toString() + 'kg';
}

String getXLabel(DateTime date) =>
    date.month.toString() + '/' + date.day.toString();

class GraphExerciseItem extends StatefulWidget {
  final SetWorkout set;

  GraphExerciseItem(this.set);

  @override
  _GraphExerciseItemState createState() => _GraphExerciseItemState();
}

class _GraphExerciseItemState extends State<GraphExerciseItem> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showMaxWeigths = false;

  List<double> maxWeigthInSets;
  List<double> volumeIntervals;

  @override
  void initState() {
    maxWeigthInSets = getMaxWeigth(widget.set.exercise.lastWorkouts);
    volumeIntervals = getVolumeIntervals(widget.set.exercise.lastWorkouts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final sets = widget.set.exercise.lastWorkouts;

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Color(0xff232d37)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      widget.set.exercise.name,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          setState(() {
                            showMaxWeigths = !showMaxWeigths;
                          });
                        },
                        icon: FaIcon(
                            showMaxWeigths
                                ? FontAwesomeIcons.trophy
                                : FontAwesomeIcons.weightHanging,
                            color: showMaxWeigths ? Colors.red : Colors.white),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          // TODO:  go to the full details screen
                        },
                        icon: FaIcon(FontAwesomeIcons.chartBar,
                            color: Colors.white),
                      ),
                    ],
                  )
                ]),
          ),
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 12, bottom: 12),
                  child: LineChart(showMaxWeigths
                      ? maxWeigths(sets, maxWeigthInSets)
                      : volumens(sets, volumeIntervals)),
                ),
              ),
            ],
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 45),
                    width: width * 0.45,
                    child: Column(
                      children: [
                        Text("Max Weight Set", // TODO REMPLACE FOR 1MR
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5))),
                        Text("${widget.set.maxWeigth} kg",
                            style: TextStyle(color: Colors.white)),
                      ],
                    )),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.5),
                ),
                Container(
                  width: width * 0.45,
                  child: Column(
                    children: [
                      Text("Workout Volume",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5))),
                      Text("${widget.set.volume.toString()} kg",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 45),
                    width: width * 0.45,
                    child: Column(
                      children: [
                        Text("Max Weigth",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5))),
                        Text("${widget.set.exercise.maxWeigth} kg",
                            style: TextStyle(color: Colors.white)),
                      ],
                    )),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.5),
                ),
                Container(
                  width: width * 0.45,
                  child: Column(
                    children: [
                      Text("Max Volume",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5))),
                      Text("${widget.set.exercise.maxVolume} kg",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  LineChartData volumens(List<SetResume> sets, List<double> intervals) {
    var interval = ((intervals[1] - intervals[0]) / 10);
    // interval += 10 - (interval % 10);
    print(intervals);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (i) => getXLabel(sets[i.toInt()].date),
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: interval,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => getYLabel(value),
          reservedSize: 40,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: sets.length.toDouble() - 1,
      minY: intervals[0],
      maxY: intervals[1],
      lineBarsData: [
        LineChartBarData(
          spots: sets.reversed
              .mapIndex((e, i) => FlSpot(i.toDouble(), e.volume))
              .toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData maxWeigths(List<SetResume> sets, List<double> intervals) {
    final interval = (intervals[0] - intervals[1]) / 8;
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (index) => getXLabel(sets[index.toInt()].date),
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: interval,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => getYLabel(value),
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: sets.length.toDouble() - 1,
      minY: 0,
      maxY: intervals[0],
      lineBarsData: [
        LineChartBarData(
          spots: sets.reversed
              .mapIndex((e, i) => FlSpot(i.toDouble(), e.maxWeigth))
              .toList(),
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
