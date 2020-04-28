import 'package:flutter/material.dart';


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
