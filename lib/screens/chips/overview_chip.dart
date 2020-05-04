import 'dart:io';
import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class OverviewChip extends StatefulWidget {
  @override
  _OverviewChipState createState() => _OverviewChipState();
}

class _OverviewChipState extends State<OverviewChip> {
  int imagesCaptured = 0;
  int audioRecorded = 0;

  @override
  void initState() {
    super.initState();
    setBirdCount();
  }

  Future<void> setBirdCount()  async {
    Directory imgDir = Directory('/storage/emulated/0/AiBirdie/Images');
    var temp = imgDir.list();
    var images = await temp.toList();
    Directory audDir = Directory('/storage/emulated/0/AiBirdie/Audios');
    var temp2 = audDir.list();
    var audios = await temp2.toList();

    setState(() {
      imagesCaptured = images.length;
      audioRecorded = audios.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                          child: Container(
                height: 150.00,
                // width: 100.00,
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
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                        "Images",
                        style: level2softdp.copyWith(fontSize: 20),
                      ),
                      Text(
                        "Captured",
                        style: level2softdp.copyWith(fontSize: 20),
                      ),
                        ],
                      ),
                      Text(
                        "$imagesCaptured",
                        style: level2softg.copyWith(
                              fontSize: 40, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
                          child: Container(
          height: 150.00,
          // width: 100.00,
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
              padding: EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Audio",
                        style: level2softdp.copyWith(fontSize: 20),
                      ),
                      Text(
                        "Recorded",
                        style: level2softdp.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    "$audioRecorded",
                    style: level2softg.copyWith(
                        fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
          ),
        ),
            ),
          ],
        ),
        SizedBox(height: 20),
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
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Accuracy",
                      style: level2softdp.copyWith(fontSize: 20),
                    ),
                    Text(
                      "Level",
                      style: level2softdp.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  "73%",
                  style: level2softg.copyWith(
                      fontSize: 40, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
