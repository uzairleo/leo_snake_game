import 'dart:async';
import 'dart:math';
// import 'package:control_pad/views/circle_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_snake_game/customJoystick.dart';
import './Widgets/widgets_at_different_game_state.dart';

// import 'package:control_pad/control_pad.dart';
enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { START, RUNNING, FAILURE }
int score = 0;
Direction direction = Direction.UP;
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Text("")),
      appBar: gameAppBar(),
      backgroundColor: Colors.brown[500],
      body: gameBody(),
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
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.03,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 26.0,
                                  child: Image.asset('Assets/leo.png'),
                                ),
                                SizedBox(width: 18.0),
                                Text(
                                  "Uzair Leo",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            chipWidget(
                              hh: 36,
                              ww: 110,
                              iconData: Icons.mail,
                              iconSize: 18.0,
                              label: "Contact",
                              onPressed: () {},
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "  \t\t\t ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      ",
                              style: TextStyle(
                                  fontSize: 3.0, color: Colors.black38),
                            ),
                            Text(
                              "Social Links",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black38),
                            ),
                            Text(
                              "  \t\t\t ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      ",
                              style: TextStyle(
                                  fontSize: 3.0, color: Colors.black38),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: chipWidget(
                                  hh: 36,
                                  ww: 99,
                                  color: Colors.white,
                                  iconData: FontAwesomeIcons.github,
                                  iconSize: 30.0,
                                  label: "Github",
                                  iconColor: Colors.black,
                                  textColor: Colors.black87,
                                  onPressed: () {},
                                )),
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: chipWidget(
                                  hh: 36,
                                  ww: 110,
                                  color: Colors.white,
                                  iconData: FontAwesomeIcons.linkedinIn,
                                  iconSize: 20.0,
                                  label: "LinkedIn",
                                  iconColor: Colors.lightBlue,
                                  textColor: Colors.black87,
                                  onPressed: () {},
                                )),
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: chipWidget(
                                  hh: 36,
                                  ww: 113,
                                  color: Colors.white,
                                  iconData: FontAwesomeIcons.facebook,
                                  iconSize: 26.0,
                                  label: "Facebook",
                                  iconColor: Colors.blue,
                                  textColor: Colors.black87,
                                  onPressed: () {},
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: chipWidget(
                                  hh: 36,
                                  ww: 105,
                                  color: Colors.white,
                                  iconData: FontAwesomeIcons.twitter,
                                  iconSize: 26.0,
                                  label: "Twitter",
                                  iconColor: Colors.blue,
                                  textColor: Colors.black87,
                                  onPressed: () {},
                                )),
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: chipWidget(
                                  hh: 36,
                                  ww: 130,
                                  color: Colors.blue,
                                  iconData: Icons.star,
                                  iconSize: 20.0,
                                  label: "Rate this app",
                                  iconColor: Colors.yellow,
                                  textColor: Colors.white,
                                  onPressed: () {},
                                )),
                          ],
                        ),
                        Text(
                          "Version 1.0.0",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black45),
                        ),
                        Text(
                          "Made with ❤️💓 in Pakistan",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black45),
                        ),
                      ]),
                    );
                  });
            })
      ],
      title: Text(
        "Score $score",
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
      centerTitle: true,
    );
  }

  chipWidget(
      {double ww,
      double hh,
      Function onPressed,
      String label,
      var iconData,
      var iconSize,
      var color,
      var iconColor,
      var textColor}) {
    return Container(
      width: ww,
      height: hh,
      child: FloatingActionButton.extended(
        // splashColor: Colors.transparent,
        backgroundColor: color,
        elevation: 4,
        onPressed: onPressed,
        label: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 11),
        ),
        icon: Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
      ),
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
                width: 320,
                height: 320,
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
              style: TextStyle(color: Colors.red),
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
