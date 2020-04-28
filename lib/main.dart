import 'package:flutter/material.dart';
import 'package:leo_snake_game/Game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olden Days Snake Game',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        title:Text("Score $score"),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[500],
      body: Game(),
    );
  }
}