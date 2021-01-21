import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphExerciseItem extends StatefulWidget {
  @override
  _GraphExerciseItemState createState() => _GraphExerciseItemState();
}

class _GraphExerciseItemState extends State<GraphExerciseItem> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          Text("DeadLift", style: TextStyle(color: Colors.white, fontSize: 24)),
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  // margin: EdgeInsets.all(10),
                  // decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(18),
                  //     ),
                  //     color: Color(0xff232d37)),

                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  icon: Icon(Icons.ac_unit,
                      color: showAvg
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white),
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
                        Text("1MR",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5))),
                        Text("4848.546kg ",
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
                      Text("1230.0kg", style: TextStyle(color: Colors.white)),
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
                        Text("4848.546kg ",
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
                      Text("1230.0kg", style: TextStyle(color: Colors.white)),
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

  LineChartData mainData() {
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
          getTitles: (value) {
            print(value);
            switch (value.toInt()) {
              case 0:
                return '11/11';
              case 1:
                return '11/12';
              case 2:
                return '11/13';
              case 3:
                return '11/14';
              case 4:
                return '11/15';
              case 5:
                return '11/16';
              case 6:
                return '11/17';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              // could be the date here
              case 0:
                return '0kg';
              case 1:
                return '10kg';
              case 1:
                return '10kg';
              case 2:
                return '20kg';
              case 3:
                return '30kg';
              case 4:
                return '40kg';
              case 5:
                return '50kg';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 3),
          ],
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

  LineChartData avgData() {
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
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
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
