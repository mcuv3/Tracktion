import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String assetName = 'assets/vectors/home.svg';

class HomeVector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              assetName,
              height: mediaQuery.size.height * 0.2,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
