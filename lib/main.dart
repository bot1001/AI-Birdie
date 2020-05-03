// import 'dart:io';

// import 'package:aibirdie/constants.dart';
// import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/landing_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  [
    Permission.storage,
    Permission.camera,
    Permission.microphone,
  ].request();
SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

// aibirde.create().then((a) {
//           imageDir.create().then((a) {
//             audioDir.create();
//             print('aama to gayu ho bhai');
//           });
//         });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Birdie',
      theme: ThemeData(
          // primarySwatch: Color(0xff1D1B27),
          primaryColor: darkPurple),
      home: LandingPage(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
