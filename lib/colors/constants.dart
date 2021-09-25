import 'package:flutter/material.dart';

List<BoxShadow> shadowList = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 3,
    offset: Offset(0, 3), // changes position of shadow
  )
];

List<BoxShadow> shadowListDanger = [
  BoxShadow(
    color: const Color(0xFFEF5350),
    spreadRadius: 2,
    blurRadius: 3,
    offset: Offset(0, 3), // changes position of shadow
  )
];

BoxDecoration boxDecoration = BoxDecoration(
    boxShadow: shadowList, borderRadius: BorderRadius.circular(5));
