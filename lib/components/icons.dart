import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

Widget inputIcon(String text, IconData icon, Function onTap){
  return Column(
    children: <Widget>[

      IconButton(
        iconSize: 150,
        color: myBlue,
        icon: Icon(icon),
        onPressed: onTap,
      ),
      Text(text, style: level1.copyWith(color: Colors.black),),

    ],

  );
}