// import 'package:aibirdie/constants.dart';
import 'dart:io';

import 'package:aibirdie/screens/audio_classification.dart';
import 'package:aibirdie/screens/cs.dart';
import 'package:aibirdie/screens/soft_dashboard.dart';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

List<CameraDescription> cameras;

class LandingPage extends StatefulWidget {
  static PageController controller =
      PageController(initialPage: 1, keepPage: false);

  LandingPage(List<CameraDescription> icameras) {
    cameras = icameras;
  }
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _currentPage = 1;
  var _pages = [
    SoftDashboard(),
    CS(cameras),
    // Container(),
    AudioClassification(),
  ];

  @override
  void initState() {
    super.initState();
    createDirectories();
  }

  void createDirectories() async {
    Directory aibirdie = Directory('/storage/emulated/0/AiBirdie');
    Directory imageDir = Directory('/storage/emulated/0/AiBirdie/Images');
    Directory audioDir = Directory('/storage/emulated/0/AiBirdie/Audios');
    Directory notesDir = Directory('/storage/emulated/0/AiBirdie/Notes');
    File notesFile = File('/storage/emulated/0/AiBirdie/Notes/notes.txt');
    File checkFile = File('/storage/emulated/0/AiBirdie/Notes/checklist.txt');
    if (!await aibirdie.exists()) await aibirdie.create();
    if (!await imageDir.exists()) await imageDir.create();
    if (!await audioDir.exists()) await audioDir.create();
    if (!await notesDir.exists()) await notesDir.create();
    if (!await notesFile.exists()) await notesFile.writeAsString('');
    if (!await checkFile.exists()) await checkFile.writeAsString('');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: PageView.builder(
          dragStartBehavior: DragStartBehavior.down,
          controller: LandingPage.controller,
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
          onPageChanged: ((index) => setState(() => _currentPage = index)),
        ),
      ),
      // return new Future(() => exitApp);
    );
  }

  Future<bool> _willPopCallback() async {
    if (_currentPage == 1)
      return true;
    else
      LandingPage.controller.animateToPage(1,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

    return false;
  }
}
