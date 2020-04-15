import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/components/transitions.dart';
// import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/screens/audio_classification.dart';
import 'package:aibirdie/screens/landing_page.dart';
// import 'package:aibirdie/screens/dashboard.dart';
import 'package:aibirdie/screens/preview_page.dart';
// import 'package:aibirdie/screens/soft_dashboard.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:swipedetector/swipedetector.dart';

class CS extends StatefulWidget {
  final List<CameraDescription> cameras;
  CS(this.cameras);

  @override
  _CSState createState() => _CSState();
}

class _CSState extends State<CS> {
  CameraController controller;
  var sca = 1.0;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initCameraController(widget.cameras[0]).then((void v) {});
    // print("camera initiated");
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          // fit: StackFit.passthrough,
          children: <Widget>[
            _cameraPreviewWidget(context),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
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
                                  builder: (context) =>
                                      PreviewPage(image, Storage()),
                                ),
                              );
                          },
                        )
                      ],
                    ),
                    // Expanded(
                    //   child: Container(
                    //     color: Colors.red,
                    //     child: SwipeDetector(
                    //       onSwipeLeft: () => myTransition(
                    //           context, 1.0, 0.0, AudioClassification()),
                    //       onSwipeRight: () =>
                    //           myTransition(context, -1.0, 0.0, Dashboard()),
                    //       swipeConfiguration: SwipeConfiguration(
                    //           horizontalSwipeMaxHeightThreshold: 100.0,
                    //           horizontalSwipeMinDisplacement: 10.0,
                    //           horizontalSwipeMinVelocity: 10.0),
                    //       child: Container(
                    //         color: Colors.transparent,
                    //         width: double.infinity,
                    //         // height: height * 0.6,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Hero(
                            tag: 'key',
                            child: Container(
                              height: 80,
                              // width: 70.00,
                              decoration: BoxDecoration(
                                // color: Color(0xffe90328),
                                // color: Colors.red[700],
                                border: Border.all(
                                    width: 5.00, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          onTap: () {
                            // print('haltu kem bandh thai gayu?');
                            _onCapturePressed(context);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                IconButton(
                                  onPressed: (()=> LandingPage.controller.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut)),
                                  // onPressed: () {
                                  //   myTransition(
                                  //       context, -1.0, 0.0, SoftDashboard());
                                  // },
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
                                  onPressed: (()=>LandingPage.controller.animateToPage(2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut)),
                                  // onPressed: () => myTransition(
                                  //     context, 1.0, 0.0, AudioClassification()),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
    return MeasureSize(
      onChange: (size) {
          // print('Screen height ${MediaQuery.of(context).size.aspectRatio}');
          // print('Widget height ${size.height}');
          // print('Scale $sca');
            setState(() {
              // print(MediaQuery.of(context).size.aspectRatio);
              sca = MediaQuery.of(context).size.height / size.longestSide;
            });
      },

      // onChange: (size) => setState(() => sca = MediaQuery.of(context).size.height / size.longestSide),

      child: Transform.scale(
        scale: MediaQuery.of(context).size.aspectRatio <= (9/16) ? 1.26 : sca,
        child: Center(
          child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller)),
        ),
      ),
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

//

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
