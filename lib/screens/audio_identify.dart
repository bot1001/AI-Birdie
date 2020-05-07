// import 'package:aibirdie/screens/audio_classidication.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:aibirdie/components/buttons.dart';
import 'package:flutter_timer/flutter_timer.dart';

File file;

class AudioIdentify extends StatefulWidget {
  AudioIdentify(ifile) {
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
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          if (isPlaying == true) {
            await audioPlayer.stop();
            setState(() {
              isPlaying = false;
            });
          }

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
                  "Recording saved",
                  style: level2softdp.copyWith(fontSize: 25),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async {
                          if (isPlaying == true) {
                            await audioPlayer.stop();
                            setState(() => isPlaying = false);
                          } else {
                            await audioPlayer.play(file.path, isLocal: true);
                            setState(() => isPlaying = true);
                            audioPlayer.onPlayerCompletion.listen(
                                (event) => setState(() => isPlaying = false));
                          }
                        },
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TikTikTimer(
                                backgroundColor: Colors.white,
                                timerTextStyle:
                                    level2softdp.copyWith(fontSize: 20),
                                height: 50,
                                width: 100,
                                running: isPlaying,
                                initialDate: DateTime.now()),
                            Icon(
                              isPlaying == true ? Icons.stop : Icons.play_arrow,
                              size: 40,
                              color:
                                  isPlaying == true ? Colors.red[900] : myGreen,
                            ),
                          ],
                        ),
                      ),
                    ),
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
