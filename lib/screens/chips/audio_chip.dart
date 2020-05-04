import 'dart:io';

// import 'package:aibirdie/constants.dart';
import 'package:aibirdie/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AudioChip extends StatefulWidget {
  @override
  _AudioChipState createState() => _AudioChipState();
}

class _AudioChipState extends State<AudioChip> {
  var audios = [];
  AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = [];
  var seekPosition = 0.0;
  var audioDuration = 10.0;

  @override
  void initState() {
    readAudios();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  Future<void> readAudios() async {
    Directory audDir = Directory('/storage/emulated/0/AiBirdie/Audios');
    var temp = audDir.list();
    audios = await temp.toList();
    setState(() {
      for (var i = 0; i < audios.length; i++) isPlaying.add(false);
    });
  }

  void deleteAudio(index) {
    File f = audios[index];
    f.delete();
    readAudios();
  }

  @override
  Widget build(BuildContext context) {
    return audios.length == 0
        ? noRecordingWidget(context)
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: audios.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(audios[index].path),
                onDismissed: (a) {
                  deleteAudio(index);
                  if (isPlaying[index] == true) {
                    audioPlayer.stop();
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),

                  // height: 200,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: isPlaying[index] == true
                        ? Color(0xff242424)
                        : Color(0xfff5f5f5),
                    // image: DecorationImage(image: AssetImage('images/listen.png'), fit: BoxFit.fitHeight),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Row(
                      //   children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 75,
                        width: 75,
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          onPressed: () async {
                            if (isPlaying.indexOf(true) != -1 &&
                                isPlaying[index] == false) {
                              audioPlayer.stop();
                              setState(() =>
                                  isPlaying[isPlaying.indexOf(true)] = false);
                              File f = audios[index];
                              audioPlayer.play(f.path, isLocal: true);
                              setState(() => isPlaying[index] = true);
                              return;
                            }

                            if (isPlaying[index] == true) {
                              audioPlayer.stop();
                              setState(() => isPlaying[index] = false);
                            } else {
                              setState(() => isPlaying[index] = true);

                              audioPlayer.onAudioPositionChanged.listen((a) {
                                setState(() => seekPosition =
                                    a.inMicroseconds.toDouble() / 1000000);
                              });

                              File f = audios[index];
                              audioPlayer.play(f.path, isLocal: true);

                              audioPlayer.durationHandler = (duration) =>
                                  setState(() => audioDuration =
                                      duration.inMicroseconds.toDouble() /
                                          1000000);
                              // print('Maxi: $audioDuration');

                            }
                            audioPlayer.onPlayerCompletion.listen((event) =>
                                setState(() => isPlaying[index] = false));
                          },
                          child: isPlaying[index]
                              ? Icon(
                                  FontAwesomeIcons.stop,
                                  size: 20,
                                )
                              : Icon(
                                  FontAwesomeIcons.play,
                                  size: 20,
                                ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              titleWidget(audios[index], index),
                              Slider(
                                activeColor: softGreen,

                                inactiveColor: Color(0xffe7e6eb),
                                value: isPlaying[index] ? seekPosition : 0,
                                min: 0,
                                max: audioDuration,
                                // divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    seekPosition = value;
                                  });
                                },

                                onChangeEnd: (value) {
                                  audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      //   ],
                      // ),
                      IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteAudio(index);
                          }),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget noRecordingWidget(BuildContext context) {
    return Container(
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
        height: MediaQuery.of(context).size.height * 0.3,
        // color: Colors.red,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.library_music,
              size: 40,
              color: softGreen,
            ),
            Column(
              children: <Widget>[
                Text(
                  "No recordings to show.",
                  style: level2softdp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Click on",
                      style: level2softdp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: softGreen,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    Text(
                      "and then go to Audio section.",
                      style: level2softdp,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )));
  }

  Widget titleWidget(File f, int index) {
    return Text(
      DateFormat("dd MMM, yyyy").format(f.lastModifiedSync()) +
          " " +
          DateFormat("H:m").format(f.lastModifiedSync()),
      style: isPlaying[index] == true ? level2softw : level2softdp,
    );
  }
}
