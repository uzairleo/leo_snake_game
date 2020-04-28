import 'package:control_pad/views/circle_view.dart';
import 'package:flutter/material.dart';

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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   width: 100,
              //   height: 100,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1.0, color: Colors.red),
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: Text(
              //     "Score\n$score",
              //     // "",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Stack(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // JoystickView(),
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
                      left: 134,
                      top: 68,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white54,
                        ),
                        onPressed: () {},
                      )),
                  Positioned(
                      left: 8,
                      top: 68,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white54,
                        ),
                        onPressed: () {},
                      )),
                  Positioned(
                      left: 65,
                      top: 6.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Colors.white54,
                        ),
                        onPressed: () {},
                      )),
                  Positioned(
                    left: 65,
                    top: 127,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.white54,
                        ),
                        onPressed: () {}),
                  ),

                  Positioned(
                    left: 50.0,
                    top: 51.5,
                    child:Icon(Icons.tag_faces,size: 80,color:Colors.white24,)
                  )// JoystickView(),

                  // Padding(
                  //   padding: EdgeInsets.only(right: 50),
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _direction = Direction.UP;
                  //       });
                  //     },
                  //     color: Colors.green,
                  //     child: Icon(Icons.keyboard_arrow_up),
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     RaisedButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           _direction = Direction.LEFT;
                  //         });
                  //       },
                  //       color: Colors.yellow,
                  //       child: Icon(Icons.keyboard_arrow_left),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 10),
                  //       child: RaisedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             _direction = Direction.RIGHT;
                  //           });
                  //         },
                  //         color: Colors.yellow,
                  //         child: Icon(Icons.keyboard_arrow_right),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(right: 50),
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _direction = Direction.DOWN;
                  //       });
                  //     },
                  //     color: Colors.green,
                  //     child: Icon(Icons.keyboard_arrow_down),
                  //   ),
                  // ),
                ],
              ),
            ],
          ));
  }
}