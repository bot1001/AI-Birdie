import 'package:aibirdie/screens/audio_screen.dart';
import 'package:aibirdie/screens/camera_screen.dart';
import 'package:aibirdie/screens/dashboard.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

List<CameraDescription> cameras;
List allPages = [
  Dashboard(),
  CameraScreen(cameras),
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
  bool exitApp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, position) {
            return allPages[position];
          },
          itemCount: allPages.length,
          controller: PageController(initialPage: 1),
        ),
      ),
      onWillPop: () async {
        // print("Back pressed");
        await Alert(
          context: context,
          type: AlertType.warning,
          title: "Are you sure to exit AI Birdie?",
          // desc: "Flutter is more awesome with RFlutter Alert.",
          buttons: [
            DialogButton(
              child: Text(
                "YES",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() => exitApp = true);
                Navigator.of(context).pop();
              },
              width: 120,
            ),
            DialogButton(
              child: Text(
                "NO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
              width: 120,
            )
          ],
        ).show();
        return new Future(() => exitApp);
      },
    );
  }
}
