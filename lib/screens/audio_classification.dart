// import 'dart:io';

import 'package:aibirdie/components/transitions.dart';
import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/audio_identify.dart';
import 'package:aibirdie/screens/audio_record.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipedetector/swipedetector.dart';

class AudioClassification extends StatefulWidget {
  @override
  _AudioClassificationState createState() => _AudioClassificationState();
}

class _AudioClassificationState extends State<AudioClassification> {
  // File file;
  // bool isPlaying;
  // IconData playIcon = Icons.play_arrow;
  // AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Pick an audio",
          style: TextStyle(color: myGreen),
        ),
        elevation: 0,
      ),

      // backgroundColor: myGreen,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SwipeDetector(
              onSwipeRight: () => Navigator.of(context).pop(),
              swipeConfiguration: SwipeConfiguration(
                  horizontalSwipeMaxHeightThreshold: 100.0,
                  horizontalSwipeMinDisplacement: 10.0,
                  horizontalSwipeMinVelocity: 10.0),
              child: Container(
                color: Colors.white,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DragTarget(
                    onAccept: (val) async {
                      file = await FilePicker.getFile(type: FileType.audio);
                      if (file != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AudioIdentify(file)));
                      }
                    },
                    builder: (a, b, c) {
                      return Container(
                        width: 100,
                        height: 100,
                        child: RaisedButton(
                          color: myGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            FontAwesomeIcons.solidFileAudio,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            file = await FilePicker.getFile(
                                type: FileType.audio);
                            if (file != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AudioIdentify(file)));
                            }
                          },
                        ),
                      );
                    },
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_up,
                            color: myGreen,
                          ),
                          Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                            color: myGreen,
                          ),
                        ],
                      ),
                      Draggable(
                        child: CircleAvatar(
                          radius: 35,
                          child: Text("Select"),
                        ),
                        feedback: CircleAvatar(
                          radius: 35,
                          child: Text("Select"),
                        ),
                        childWhenDragging: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                        ),
                        axis: Axis.vertical,
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: myGreen,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: myGreen,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Hero(
                    tag: 'mic',
                    child: DragTarget(
                      onAccept: (value) {
                        myTransition(context, 1.0, 0.0, AudioRecord());
                      },
                      builder: (a, b, c) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: RaisedButton(
                              color: myGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.mic,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                myTransition(
                                    context, 1.0, 0.0, AudioRecord());
                              }),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    child: Hero(
                      tag: 'key',
                      child: Container(
                        child: Icon(Icons.camera_alt),
                        height: 50.00,
                        width: 50.00,
                        decoration: BoxDecoration(
                          // color: Color(0xffe90328),
                          // color: Colors.red[700],
                          border:
                              Border.all(width: 5.00, color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
