import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String assetName = 'assets/vectors/home.svg';

class HomeVector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: Center(
        child: SvgPicture.asset(
          assetName,
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
