// import 'dart:async';
// import 'dart:async';
import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:path_provider/path_provider.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  File file;
  bool isPlaying;
  IconData playIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();
  int sec = 0;
  // String rec = "Record now";

  @override
  void initState() {
    super.initState();
    file = null;
    isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    var recorder;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Audio Classification",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0,
      ),
      body: SafeArea(
        child: Center(
          child: file == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Select audio file",
                          style: level2,
                        ),
                        IconButton(
                          onPressed: () async {
                            file =
                                await FilePicker.getFile(type: FileType.AUDIO);
                            // print(file.path);
                            setState(() {});
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidFileAudio,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () async {

                                final String filePath =
                                    '/storage/emulated/0/AiBirdie/${DateTime.now().millisecondsSinceEpoch.toString()}.wav';
                                print(filePath);
                                recorder = FlutterAudioRecorder(filePath,
                                    audioFormat: AudioFormat.WAV);

                                await FlutterAudioRecorder.hasPermissions;

                                await recorder.initialized;
                                await recorder.start();
                                // var recording = await recorder.current(channel: 0);
                              },
                              icon: Icon(
                                FontAwesomeIcons.microphone,
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              onPressed: () async {
                                var result = await recorder.stop();
                                file = File(result.path);
                                // print(result.path);
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.stop,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Text(
                          "Record now",
                          style: level2,
                        ),
                      
                        // Text(
                        //   "00:0$sec",
                        //   style: level2,
                        // ),
                      ],
                    ),
                      // SizedBox(
                      //     height: 100,
                      //   ),
                    Column(
                      children: <Widget>[
                        Hero(
                          tag: 'key',
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                                                      child: Container(
                              height: 40.00,
                              width: 40.00,
                              decoration: BoxDecoration(
                                // color: Color(0xffe90328),
                                // color: Colors.red[700],
                                border: Border.all(width: 5.00, color: Colors.black),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "File picked, listen here",
                      style: level2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            size: 50,
                          ),
                          onPressed: () async {
                            await audioPlayer.play(file.path, isLocal: true);
                            // print(result);
                            audioPlayer.onPlayerCompletion.listen((event) {
                              setState(() {
                                isPlaying = false;
                                playIcon = Icons.play_arrow;
                              });
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.stop, size: 50),
                          onPressed: () async {
                            await audioPlayer.stop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                
        ),
      ),
    );
  }
}
