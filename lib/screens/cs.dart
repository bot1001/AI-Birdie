import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/components/transitions.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/audio_classidication.dart';
import 'package:aibirdie/screens/dashboard.dart';
import 'package:aibirdie/screens/preview_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipedetector/swipedetector.dart';

class CS extends StatefulWidget {
  final List<CameraDescription> cameras;
  CS(this.cameras);

  @override
  _CSState createState() => _CSState();
}

class _CSState extends State<CS> {
  CameraController controller;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initCameraController(widget.cameras[0]).then((void v) {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container(
        child: Center(
          child: Text("Controller not initialized yet."),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "AI Birdie",
                    style: level1w.copyWith(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () async {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      // print(image.path);
                      if (image != null)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewPage(image, Storage()),
                          ),
                        );
                    },
                  )
                ],
              ),
            ),
          ),
          _cameraPreviewWidget(context),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
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
                  Column(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCameraException(CameraException e) {
    print("Error: ${e.code}\n${e.description}");
    // showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  // String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

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

  Widget _cameraPreviewWidget(context) {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
      );
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Column(
              children: <Widget>[
                Expanded(
                  child: SwipeDetector(
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
                      width: double.infinity,
                      // height: height * 0.6,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Hero(
                    tag: 'key',
                    child: Container(
                      height: 80,
                      // width: 70.00,
                      decoration: BoxDecoration(
                        // color: Color(0xffe90328),
                        // color: Colors.red[700],
                        border: Border.all(width: 5.00, color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  onTap: () {
                    // print('haltu kem bandh thai gayu?');
                    _onCapturePressed(context);
                  },
                ),
              ],
            ),
          ],
        ));
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
