import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:aibirdie/components/buttons.dart';

File file;
class AudioIdentify extends StatefulWidget {
  AudioIdentify(ifile){
    file = ifile;
  }
  @override
  _AudioIdentifyState createState() => _AudioIdentifyState();
}

class _AudioIdentifyState extends State<AudioIdentify> {
    bool isPlaying;
  // IconData playIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "File picked successfully",
                style: level2,
              ),
            
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  lightButton("Listen", () async {
                    await audioPlayer.play(file.path, isLocal: true);
                    audioPlayer.onPlayerCompletion.listen((event) {
                      setState(() {
                        isPlaying = false;
                      });
                    });
                  }),
                  SizedBox(height: 20,),
                  solidButton("Identify", () {})
                ],
              ),


            ],

      ),
        ),
    ),
      
    );
  }
}