import 'package:aibirdie/screens/landing_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(),
      home: LandingPage(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
