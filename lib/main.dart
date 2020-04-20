// import 'dart:io';

// import 'package:aibirdie/constants.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/landing_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Birdie',
      theme: ThemeData(
        // primarySwatch: Color(0xff1D1B27),
        primaryColor: darkPurple
      ),
      home: LandingPage(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
