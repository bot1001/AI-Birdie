import 'package:aibirdie/screens/audio_screen.dart';
import 'package:aibirdie/screens/camera_screen.dart';
import 'package:aibirdie/screens/dashboard.dart';
import 'package:aibirdie/screens/history.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;
List allPages = [
  Dashboard(),
  PageView(
    controller: PageController(initialPage: 0),
    scrollDirection: Axis.vertical,
    children: <Widget>[
      CameraScreen(cameras),
      History(),
    ],
  ),
  AudioScreen(),
];

class LandingPage extends StatefulWidget {
  LandingPage(List<CameraDescription> icameras) {
    cameras = icameras;
  }
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          return allPages[position];
        },
        itemCount: allPages.length,
        controller: PageController(initialPage: 1),
      ),
    );
  }
}
