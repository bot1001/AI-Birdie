import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class OverviewChip extends StatefulWidget {
  @override
  _OverviewChipState createState() => _OverviewChipState();
}

class _OverviewChipState extends State<OverviewChip> {
  int birdsCaptured = 0;

  @override
  void initState() {
    super.initState();
    setBirdsCapturedCount();
  }

  Future<void> setBirdsCapturedCount()  async {
    Directory imgDir = Directory('/storage/emulated/0/AiBirdie/Images');
    var temp = imgDir.list();
    var images = await temp.toList();
    setState(() {
      birdsCaptured = images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150.00,
          // width: 315.00,
          decoration: BoxDecoration(
            color: Color(0xfff5f5f5),
            boxShadow: [
              BoxShadow(
                offset: Offset(-6.00, -6.00),
                color: Color(0xffffffff).withOpacity(0.80),
                blurRadius: 10,
              ),
              BoxShadow(
                offset: Offset(6.00, 6.00),
                color: Color(0xff000000).withOpacity(0.20),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(15.00),
          ),
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Birds",
                      style: level2softdp.copyWith(fontSize: 25),
                    ),
                    Text(
                      "Captured",
                      style: level2softdp.copyWith(fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  "$birdsCaptured",
                  style: level2softg.copyWith(
                      fontSize: 55, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 150.00,
          // width: 315.00,
          decoration: BoxDecoration(
            color: Color(0xfff5f5f5),
            boxShadow: [
              BoxShadow(
                offset: Offset(-6.00, -6.00),
                color: Color(0xffffffff).withOpacity(0.80),
                blurRadius: 10,
              ),
              BoxShadow(
                offset: Offset(6.00, 6.00),
                color: Color(0xff000000).withOpacity(0.20),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(15.00),
          ),
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Accuracy",
                      style: level2softdp.copyWith(fontSize: 25),
                    ),
                    Text(
                      "Level",
                      style: level2softdp.copyWith(fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  "73%",
                  style: level2softg.copyWith(
                      fontSize: 55, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
