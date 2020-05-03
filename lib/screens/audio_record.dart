import 'dart:io';

import 'package:aibirdie/components/buttons.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/audio_identify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_set/widget/transition_animations.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_timer/flutter_timer.dart';

class AudioRecord extends StatefulWidget {
  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  var running, recorder;
  File file;

  @override
  void initState() {
    super.initState();

    startRecording();
  }

  Future startRecording() async {
    final String filePath =
        '/storage/emulated/0/AiBirdie/Audios/${DateTime.now().millisecondsSinceEpoch.toString()}.wav';
    print(filePath);
    recorder = FlutterAudioRecorder(filePath, audioFormat: AudioFormat.WAV);

    await FlutterAudioRecorder.hasPermissions;

    await recorder.initialized;
    await recorder.start();
    // var recording = await recorder.current(channel: 0);

    setState(() {
      running = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Hero(
                  tag: 'mic',
                  child: Container(
                    width: 80,
                    height: 80,
                    child: RaisedButton(
                        color: Color(0xff8fc551),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.mic,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Container(
                  child: YYDoubleBounce(),
                  color: Colors.black,
                  width: 50,
                  height: 50,
                ),
                Text(
                  "Recording...",
                  style: level2w,
                ),
                TikTikTimer(
                  initialDate: DateTime.now(),
                  running: running,
                  height: 150,
                  width: double.infinity,
                  // backgroundColor: Colors.black,
                  timerTextStyle: level2w.copyWith(fontSize: 60),
                  borderRadius: 100,
                  // isRaised: true,
                  tracetime: (time) {
                    print(time.getCurrentSecond);
                  },
                ),
                solidButton("End Recording", () async {
                  var result = await recorder.stop();
                  file = File(result.path);
                  setState(() {
                    running = false;
                  });
                  if (file != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AudioIdentify(file)));
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
