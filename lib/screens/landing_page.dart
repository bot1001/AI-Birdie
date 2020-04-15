
// import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/audio_classification.dart';
import 'package:aibirdie/screens/cs.dart';
import 'package:aibirdie/screens/soft_dashboard.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

List<CameraDescription> cameras;


class LandingPage extends StatefulWidget {
  LandingPage(List<CameraDescription> icameras) {
    cameras = icameras;
  }
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  var controller = PageController(initialPage: 1,keepPage: false);
  var _currentPage = 1;
  var _pages = [
    SoftDashboard(),
    CS(cameras),
    AudioClassification(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: PageView.builder(
          controller: controller,
          itemCount: _pages.length,
          itemBuilder: ((BuildContext context, int index) => _pages[index]),
          onPageChanged: ((index) => setState(() => _currentPage = index)),
        ),
      ),
        // return new Future(() => exitApp);
    );
  }


    Future<bool> _willPopCallback() async {
      if(_currentPage == 1)
        return true;
      else
        controller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      return false;
    }
}
