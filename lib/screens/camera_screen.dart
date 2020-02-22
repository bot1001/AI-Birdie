// import 'dart:async';
import 'dart:io';
import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/components/transitions.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/audio_classidication.dart';
// import 'package:aibirdie/screens/audio_screen.dart';
import 'package:aibirdie/screens/dashboard.dart';
import 'package:aibirdie/screens/preview_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipedetector/swipedetector.dart';
// import 'package:video_player/video_player.dart';

List<CameraDescription> cameras;
var height, width;

class CameraScreen extends StatefulWidget {
  CameraScreen(List<CameraDescription> icameras) {
    cameras = icameras;
  }
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initCameraController(cameras[0]).then((void v) {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    });
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _cameraPreviewWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "AI Birdie",
                      style: level1w.copyWith(fontSize: 20),
                    ),
                    Container(
                      width: 60,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              File image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              // print(image.path);
                              if (image != null)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PreviewPage(image, Storage()),
                                  ),
                                );
                            },
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SwipeDetector(
                onSwipeLeft: () =>
                    myTransition(context, 1.0, 0.0, AudioClassification()),
                onSwipeRight: () =>
                    myTransition(context, -1.0, 0.0, Dashboard()),
                swipeConfiguration: SwipeConfiguration(
                    horizontalSwipeMaxHeightThreshold: 100.0,
                    horizontalSwipeMinDisplacement: 10.0,
                    horizontalSwipeMinVelocity: 10.0),
                child: Container(
                  color: Colors.transparent,
                  width: width * 0.7,
                  height: height * 0.7,
                ),
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    child: Hero(
                      tag: 'key',
                      child: Container(
                        height: 85.00,
                        width: 85.00,
                        decoration: BoxDecoration(
                          // color: Color(0xffe90328),
                          // color: Colors.red[700],
                          border: Border.all(width: 5.00, color: Colors.white),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    onTap: () {
                      _onCapturePressed(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          width: 90,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  myTransition(context, -1.0, 0.0, Dashboard());
                                },
                                icon: Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              Text(
                                "Dashboard",
                                style: level1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      // Column(
                      //   // mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     SizedBox(height: 15,),
                      //     // IconButton(
                      //     //   onPressed: (){
                      //     //     // print("object");

                      //     //   },
                      //     //   icon: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30,),
                      //     // ),
                      //   ],
                      // ),
                      SizedBox(
                        width: 15,
                      ),
                      // SizedBox(
                      //   width: 100,
                      // ),
                      Container(
                          width: 90,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => myTransition(
                                    context, 1.0, 0.0, AudioClassification()),
                                icon: Icon(
                                  Icons.audiotrack,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "Audio",
                                style: level1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              // Container(
              //   // color: Colors.red,
              //   width: 150,
              //   height: 70,
              //   child: IconButton(
              //       icon: Icon(
              //         Icons.radio_button_unchecked,
              //         size: 100,
              //         semanticLabel: "aa",
              //         color: Colors.white,
              //       ),
              //       onPressed: () {
              //         _onCapturePressed(context);
              //       }),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ],
      ),
    );
  }



  void _showCameraException(CameraException e) {
    print("Error: ${e.code}\n${e.description}");
    // showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.veryHigh);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: height * 0.1),
      child: CameraPreview(controller),
    );
  }

  void _onCapturePressed(context) async {
    try {
      final path = join(
        (await getApplicationDocumentsDirectory()).path,
        '${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await controller.takePicture(path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(File(path), Storage()),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
