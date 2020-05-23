import 'dart:io';
import 'package:aibirdie/components/waves.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/components/buttons.dart';
import 'package:flutter_timer/flutter_timer.dart';
import 'package:aibirdie/screens/Audio/audio_identify.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_animation_set/widget/transition_animations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timer_builder/timer_builder.dart';

class AudioRecord extends StatefulWidget {
  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  var running;
  FlutterAudioRecorder recorder;
  String filePath;

  @override
  void initState() {
    super.initState();
    startRecording();
  }

  Future startRecording() async {
    filePath =
        '/storage/emulated/0/AiBirdie/Audios/${DateTime.now().millisecondsSinceEpoch.toString()}.wav';
    recorder = FlutterAudioRecorder(
      filePath,
      audioFormat: AudioFormat.WAV,
      sampleRate: 44100,
    );

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
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Hero(
                  //   tag: 'mic',
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     child: RaisedButton(
                  //         color: softGreen,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(100),
                  //         ),
                  //         child: Icon(
                  //           Icons.mic,
                  //           size: 30,
                  //           color: Colors.white,
                  //         ),
                  //         onPressed: () {}),
                  //   ),
                  // ),
                  Hero(
                    tag: 'mic',
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          child: YYDoubleBounce(),
                          width: 100,
                          height: 100,
                        ),
                        TimerBuilder.periodic(Duration(milliseconds: 1000),
                            builder: (context) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            child: Icon(
                              Icons.mic,
                              size: 50,
                              color: softGreen,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Text(
                    "Recording...",
                    style: level2w,
                  ),
                  AnimatedWave(
                    barColor: Colors.white,
                  ),
                  TikTikTimer(
                    initialDate: DateTime.now(),
                    running: running,
                    height: 150,
                    width: double.infinity,
                    // backgroundColor: Colors.black,
                    timerTextStyle: level2softw.copyWith(fontSize: 60),
                    borderRadius: 100,
                    // isRaised: true,
                    // tracetime: (time) {
                    //   print(time.getCurrentSecond);
                    // },
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
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    Alert(
      type: AlertType.warning,
      content: Text("Are you sure you want to discard your recording?", style: level2softdp, textAlign: TextAlign.center,),
      style: AlertStyle(
        animationType: AnimationType.fromBottom,
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(30),
          color: darkPurple,
            child: Text("Discard", style: level2softdp.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
            onPressed: () async {
              await recorder.stop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              await File(filePath).delete();
            }),
        DialogButton(
          radius: BorderRadius.circular(30),
          color: Colors.white,
          
            child: Text("Cancel", style: level2softdp.copyWith(color: softGreen, fontWeight: FontWeight.bold),),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
      context: context,
      title: "Recording in progress",
    ).show();

    return false;
  }
}
