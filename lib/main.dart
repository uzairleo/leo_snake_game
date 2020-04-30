import 'package:flutter/material.dart';
import './GameLogic/Game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olden Days Snake Game',
      home: Game(),
      debugShowCheckedModeBanner: false,
    );
  }
}
