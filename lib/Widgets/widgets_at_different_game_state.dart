import 'package:flutter/material.dart';

var snakeColor = Colors.brown[500];
final Widget gameStartChild = Container(
  width: 320,
  height: 320,
  padding: const EdgeInsets.all(32),
  child: Center(
    child: Text(
      "Tap to start the Game!\nDo not Touch Walls.",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
    ),
  ),
);

final Widget gameRunningChild = Container(
  // duration: Duration(seconds:1),
  width: 15.5,
  height: 15.5,
  decoration: new BoxDecoration(
      color: snakeColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(7.0)
      ),
);
double pointSize = 15.5;

final Widget newSnakePointInGame = AnimatedContainer(
  duration: Duration(seconds: 1),
  width: 15.5,
  height: 15.5,
  decoration: new BoxDecoration(
    color: const Color(0xFF0080FF),
    border: new Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
  ),
);

class Point {
  //This is the class which give you snake head
  double x;
  double y;

  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
