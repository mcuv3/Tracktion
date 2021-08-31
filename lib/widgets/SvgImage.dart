import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracktion/colors/constants.dart';

class SvgImage extends StatelessWidget {
  final double width;
  final double height;
  final String svgUri;
  final Color svgColor;
  final Text text;
  final bool active;
  final Color bgColor;
  SvgImage(this.svgUri,
      {this.text,
      this.svgColor,
      this.width = 110,
      this.height = 110,
      this.active = false,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: shadowList),
          padding: EdgeInsets.all(8),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgUri,
                width: width * 0.6,
                height: height * 0.6,
                color: svgColor,
              ),
              SizedBox(
                height: 5,
              ),
              text
            ],
          )),
    );
  }
}
