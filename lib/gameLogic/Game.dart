import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_snake_game/Widgets/Aboutme.dart';
import '../customJoyStick/customJoystick.dart';
import '../Widgets/widgets_at_different_game_state.dart';

AnimationController animController;
enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { START, RUNNING, FAILURE }
int score = 0;
Direction direction = Direction.UP; //by default the snake direction is up
var themeIcon = Icons.lightbulb_outline;

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  var snakePosition;
  Point newPointPosition;
  Timer timer;
  var gameState = GameState.START;
  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 1),onTimeChanged);
  }
  // onTimeChanged(Timer timer)
  // {
  //   setState(() {

  //     (pointSize==15.5)?
  //     pointSize=30.5:pointSize=15.5;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Text("")),
      appBar: gameAppBar(),
      backgroundColor: Colors.brown[500],
      body: gameBody(),
      // floatingActionButton: Container(
      //   width: 40,
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.blueGrey,
      //     onPressed: (){},
      //     child: Icon(Icons.settings),
      // ),
      // ),
    );
  }

  gameAppBar() {
    return AppBar(
      backgroundColor: Colors.brown[500],
      elevation: 0,
      leading: Icon(
        FontAwesomeIcons.gamepad,
        size: 28,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: (){
            showAboutmeSheet(context);
          },
                  child: CircleAvatar(
            backgroundColor: Colors.white70,
            radius: 22,
                    child: Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('Assets/leo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )),
            ),
          ),
        ),
        SizedBox(width:14.0)
        // IconButton(
        //     icon: Icon(FontAwesomeIcons.smile),
        //     onPressed: () {
        //       showAboutmeSheet(context);
        //     })
      ],
      title: Text(
        "Score $score",
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
      centerTitle: true,
    );
  }

  gameBody() {
    return ListView(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 325,
                height: 315,
                padding: EdgeInsets.all(29),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/snake_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: GestureDetector(
                  // behavior: HitTestBehavior.opaque,
                  onTapUp: (tapUpDetails) {
                    _handleTap(tapUpDetails);
                  },
                  child: _getChildBasedOnGameState(),
                ),
              ),
              SizedBox(height: 10.0),
              CustomJoyStick(),
            ],
          ),
        ),
      ],
    );
  }

  void _handleTap(TapUpDetails tapUpDetails) {
    switch (gameState) {
      case GameState.START:
        startToRunState();
        break;
      case GameState.RUNNING:
        break;
      case GameState.FAILURE:
        setGameState(GameState.START);
        break;
    }
  }

  void startToRunState() {
    startingSnake();
    generatenewPoint();
    direction = Direction.UP;
    setGameState(GameState.RUNNING);
    timer = new Timer.periodic(new Duration(milliseconds: 400), onTimeTick);
  }

  void startingSnake() {
    setState(() {
      final midPoint = (320 / 20 / 2);
      snakePosition = [
        Point(midPoint, midPoint - 1),
        Point(midPoint, midPoint),
        Point(midPoint, midPoint + 1),
      ];
    });
  }

  void generatenewPoint() {
    setState(() {
      Random rng = Random();
      var min = 0;
      var max = 320 ~/ 20;
      var nextX = min + rng.nextInt(max - min);
      var nextY = min + rng.nextInt(max - min);

      var newRedPoint = Point(nextX.toDouble(), nextY.toDouble());

      if (snakePosition.contains(newRedPoint)) {
        generatenewPoint();
      } else {
        newPointPosition = newRedPoint;
      }
    });
  }

  void setGameState(GameState _gameState) {
    setState(() {
      gameState = _gameState;
    });
  }

  Widget _getChildBasedOnGameState() {
    var child;
    switch (gameState) {
      case GameState.START:
        setState(() {
          score = 0;
        });
        child = gameStartChild;
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesWithNewPoints = List();
        snakePosition.forEach(
          (i) {
            snakePiecesWithNewPoints.add(
              Positioned(
                child: gameRunningChild,
                left: i.x * 15.5,
                top: i.y * 15.5,
              ),
            );
          },
        );
        final latestPoint = Positioned(
          child: newSnakePointInGame,
          left: newPointPosition.x * 15.5,
          top: newPointPosition.y * 15.5,
        );
        snakePiecesWithNewPoints.add(latestPoint);
        child = Stack(children: snakePiecesWithNewPoints);
        break;

      case GameState.FAILURE:
        timer.cancel();
        child = Container(
          width: 320,
          height: 320,
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              "You Scored: $score\nTap to play again!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        );
        break;
    }
    return child;
  }

  void onTimeTick(Timer timer) {
    setState(() {
      snakePosition.insert(0, getLatestSnake());
      snakePosition.removeLast();
    });

    var currentHeadPos = snakePosition.first;
    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > 320 / 20 ||
        currentHeadPos.y > 320 / 20) {
      setGameState(GameState.FAILURE);
      return;
    }

    if (snakePosition.first.x == newPointPosition.x &&
        snakePosition.first.y == newPointPosition.y) {
      generatenewPoint();
      setState(() {
        if (score <= 10)
          score = score + 1;
        else if (score > 10 && score <= 25)
          score = score + 2;
        else
          score = score + 3;
        snakePosition.insert(0, getLatestSnake());
      });
    }
  }

  Point getLatestSnake() {
    var newHeadPos;

    switch (direction) {
      case Direction.LEFT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return newHeadPos;
  }
}
