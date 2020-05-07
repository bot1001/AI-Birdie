import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class ImageFull extends StatelessWidget {
  final File inp;
  ImageFull({this.inp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Color(0xfffafafa),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Text("data"),
              // SizedBox(
              //   height: 20,
              // ),
              Hero(
                  tag: inp.path,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      inp,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
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
        ),
      ),
    );
  }
}
