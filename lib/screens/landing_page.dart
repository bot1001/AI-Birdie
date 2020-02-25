import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/screens/camera_screen.dart';
import 'package:aibirdie/screens/cs.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

List<CameraDescription> cameras;


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
        body: CS(cameras),
      ),
      onWillPop: () async {
        await Alert(
          context: context,
          type: AlertType.warning,
          title: "Are you sure to exit AI Birdie?",
          buttons: [
            DialogButton(
              color: Colors.red,
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
              color: myGreen,
              child: Text(
                "NO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
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
