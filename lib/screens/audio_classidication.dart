import 'dart:io';

import 'package:aibirdie/components/transitions.dart';
import 'package:aibirdie/screens/audio_identify.dart';
import 'package:aibirdie/screens/audio_record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudioClassification extends StatefulWidget {
  @override
  _AudioClassificationState createState() => _AudioClassificationState();
}

class _AudioClassificationState extends State<AudioClassification> {
  File file;
  bool isPlaying;
  IconData playIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              
              Container(
                width: 120,
                height: 120,
                child: RaisedButton(
                  color: Color(0xff8fc551),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    FontAwesomeIcons.solidFileAudio,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    file = await FilePicker.getFile(type: FileType.AUDIO);
                    if (file != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AudioIdentify(file))
                      );
                    }
                  },
                ),
              ),
              Hero(
                tag: 'mic',
                child: Container(
                  width: 120,
                  height: 120,
                  child: RaisedButton(
                      color: Color(0xff8fc551),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.mic,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        myTransition(context, 1.0, 0.0, AudioRecord());
                      }),
                ),
              ),
              GestureDetector(
                  child: Hero(
                    tag: 'key',
                    child: Container(
                      height: 50.00,
                      width: 50.00,
                      decoration: BoxDecoration(
                        // color: Color(0xffe90328),
                        // color: Colors.red[700],
                        border: Border.all(width: 5.00, color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      )),
    );
  }
}
