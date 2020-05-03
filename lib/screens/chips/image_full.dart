import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class ImageFull extends StatelessWidget {
  final File inp;
  ImageFull({this.inp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(tag: inp.path, child: Image.file(inp)),
          Container(
            height: 50,
            width: double.infinity,
            child: RaisedButton(
                color: softGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Done",
                  style: level2softw,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      )),
    );
  }
}
