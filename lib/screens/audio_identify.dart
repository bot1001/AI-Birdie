// import 'package:aibirdie/screens/audio_classidication.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:aibirdie/components/buttons.dart';

File file;

class AudioIdentify extends StatefulWidget {
  AudioIdentify(ifile) {
    file = ifile;
  }
  @override
  _AudioIdentifyState createState() => _AudioIdentifyState();
}

class _AudioIdentifyState extends State<AudioIdentify> {
  String label = "Play";

  bool isPlaying;
  // IconData playIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          await audioPlayer.stop();
          setState(() {
            isPlaying = false;
            label = "Play";
          });

          if (file.path.substring(file.path.length - 4) == ".wav") {
            Navigator.of(context).pop();
          }

          return new Future(() => true);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'images/listen.png',
                  width: double.infinity,
                ),
                Text(
                  "File picked successfully",
                  style: level2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            // width: 200,
                            child: OutlineButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () async {
                                if (isPlaying == true) {
                                  await audioPlayer.stop();
                                  setState(() {
                                    isPlaying = false;
                                    label = "Play";
                                  });
                                } else {
                                  await audioPlayer.play(file.path,
                                      isLocal: true);
                                  setState(() {
                                    label = "Stop ";
                                    isPlaying = true;
                                  });

                                  audioPlayer.onPlayerCompletion
                                      .listen((event) {
                                    setState(() {
                                      isPlaying = false;
                                      label = "Play";
                                    });
                                  });
                                }
                              },
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                  width: 1.5),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Text(label, style: level1),
                                    Icon(Icons.play_arrow),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 100,
                            child: OutlineButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () async {
                                if (isPlaying == true) {
                                  await audioPlayer.stop();
                                  setState(() {
                                    isPlaying = false;
                                    label = "Play";
                                  });
                                } else {
                                  await audioPlayer.play(file.path,
                                      isLocal: true);
                                  setState(() {
                                    label = "Stop ";
                                    isPlaying = true;
                                  });

                                  audioPlayer.onPlayerCompletion
                                      .listen((event) {
                                    setState(() {
                                      isPlaying = false;
                                      label = "Play";
                                    });
                                  });
                                }
                              },
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                  width: 1.5),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Icon(Icons.play_arrow, size: 25,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // lightButton(label, () async {
                    //   if(isPlaying == true){
                    //     await audioPlayer.stop();
                    //     setState(() {
                    //       isPlaying = false;
                    //       label = "Play ▶";
                    //     });
                    //   }
                    //   else {
                    //   await audioPlayer.play(file.path, isLocal: true);
                    //   setState(() {
                    //   label = "Stop ";
                    //   isPlaying = true;
                    //   });

                    //   audioPlayer.onPlayerCompletion.listen((event) {
                    //     setState(() {
                    //       isPlaying = false;
                    //       label = "Play";
                    //     });
                    //   });
                    //   }
                    // }),
                    SizedBox(
                      height: 20,
                    ),
                    solidButton("Identify", () {})
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
