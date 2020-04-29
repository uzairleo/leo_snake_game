import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_snake_game/Widgets/Aboutme.dart';
import '../customJoyStick/customJoystick.dart';
import '../Widgets/widgets_at_different_game_state.dart';
import 'package:flutter/services.dart';

AnimationController animController;
enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { START, RUNNING, FAILURE }
int score = 0;
Direction direction = Direction.UP; //by default the snake direction is up
var themeIcon = FontAwesomeIcons.lightbulb;
var themeColor = Color.fromARGB(255, 193, 75, 75);

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
  }

  Future<bool> onBackPressed() {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("NO"),
                  ),
                  SizedBox(height: 16),
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      exit(0);
                    },
                    child: Text("YES"),
                  ),
                ],
              );
            }) ??
        false; //null pointer check
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
          appBar: gameAppBar(),
          backgroundColor: themeColor,
          body: (MediaQuery.of(context).orientation == Orientation.portrait)
              ? gameBodyPortrait()
              : gameBodyLandscape(),
          floatingActionButton: customAnimatedFab()),
    );
  }

  customAnimatedFab() {
    return SpeedDial(
      // elevation: 0,
      tooltip: "Menu",
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      backgroundColor: Colors.blueGrey,
      overlayColor: Colors.transparent,
      shape: CircleBorder(),
      overlayOpacity: 0.6,
      marginRight: 6,
      marginBottom: 7,
      // animationSpeed: 40,
      curve: Curves.bounceIn,
      foregroundColor: Colors.white70,
      children: [
        SpeedDialChild(
          child: Icon(themeIcon, color: Colors.white),
          backgroundColor: Colors.green,
          shape: CircleBorder(),
          onTap: () {
            setState(() {
              (themeIcon == FontAwesomeIcons.lightbulb)
                  ? themeIcon = FontAwesomeIcons.solidLightbulb
                  : themeIcon = FontAwesomeIcons.lightbulb;

              (themeColor ==Color.fromARGB(255, 193, 75, 75))
                  ? themeColor = Colors.brown[500]
                  : themeColor = Color.fromARGB(255, 193, 75, 75);

              (snakeColor == Colors.brown[500])
                  ? snakeColor =Color(0xFFFF0000)
                  : snakeColor = Colors.brown[500];
            });
          },
          label: 'Theme',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.screen_rotation, color: Colors.white),
          backgroundColor: Colors.red,
          onTap: () {
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.landscapeLeft])
                : SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
          },
          label: 'Screen Orientation',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.red,
        ),
        SpeedDialChild(
          child: Icon(Icons.help, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () {
            helpDialog();
          },
          label: 'Help',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  helpDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
            title: Text("Instructions"),
            content: Text("Leo snake game is very easy to use"
                "all u need to do is to handle the"
                "the joystick u seen there in dashboar"
                "and thats it. "),
          );
        });
  }

  gameAppBar() {
    return AppBar(
      backgroundColor: themeColor,
      elevation: 0,
      leading: Icon(
        FontAwesomeIcons.gamepad,
        size: 28,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
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
        SizedBox(width: 14.0)
      ],
      title: Text(
        "Score $score",
        style: TextStyle(fontFamily: 'digital-7',color: Colors.white,
         fontSize: 42),
      ),
      centerTitle: true,
    );
  }

  gameBodyPortrait() {
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
                  behavior: HitTestBehavior.opaque,
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

  gameBodyLandscape() {
    return ListView(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(seconds: 1),
          child: Row(
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
              // SizedBox(height: 6.0),
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
