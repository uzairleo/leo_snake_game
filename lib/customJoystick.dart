import 'package:control_pad/views/circle_view.dart';
import 'package:flutter/material.dart';
import 'package:leo_snake_game/Game.dart';


class CustomJoyStick extends StatefulWidget {
  @override
  _CustomJoyStickState createState() => _CustomJoyStickState();
}

class _CustomJoyStickState extends State<CustomJoyStick> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleView.joystickCircle(
                    180,
                    Colors.blueGrey,
                  ),
                  Positioned(
                      left: 47.0,
                      top: 48.0,
                      child:
                          CircleView.joystickInnerCircle(85, Colors.blueGrey)),

                  Positioned(
                      left: 124,
                      top: 68,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            direction=Direction.RIGHT;
                          });
                        },
                      )),
                  Positioned(
                      left: 8,
                      top: 68,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            direction=Direction.LEFT;
                          });
                        },
                      )),
                  Positioned(
                      left: 65,
                      top: 6.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            direction=Direction.UP;
                          });
                        },
                      )),
                  Positioned(
                    left: 65,
                    top: 127,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          direction=Direction.DOWN;
                        }),
                  ),

                  Positioned(
                    left: 50.0,
                    top: 51.5,
                    child:Icon(Icons.tag_faces,size: 80,color:Colors.white24,)
                  ),    
                             ],
              ),
            ],
          ));
  }
}