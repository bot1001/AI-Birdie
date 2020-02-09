
//System imports
// import 'package:aibirdie/screens/home_page.dart';
// import 'package:aibirdie/screens/img_classification.dart';
import 'package:aibirdie/screens/landing_page.dart';
// import 'package:aibirdie/screens/preview_page.dart';
import 'package:camera/camera.dart';
// import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

//Screens imports
// import 'package:aibirdie/screens/login_page.dart';
// import 'package:aibirdie/screens/camera_screen.dart';

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

      home: LandingPage(cameras),
      routes: {

        // 'home_page': (context) => HomePage(),
        // 'camera_screen': (context) => CameraScreen(),
        // 'preview_page': (context) => PreviewPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}