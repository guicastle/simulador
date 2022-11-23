import 'package:flutter/material.dart';

Widget buildCircle(Color color, IconData icon) {
  return Container(
    width: 46.0,
    height: 46.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      //borderRadius: new BorderRadius.circular(30.0),
      color: color.withAlpha(30),
    ),
    child: Center(
        child: Icon(
      icon,
      color: color,
    )),
  );
}
