import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './ChipWidget.dart';
showAboutmeSheet(BuildContext context){
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
       
}