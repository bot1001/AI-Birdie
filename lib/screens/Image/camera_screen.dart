import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/landing_page.dart';
import 'package:aibirdie/screens/Image/image_result.dart';

import '../landing_page.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  var sca = 1.0;
  var animatedHeight = 80.0;
  var animatedMargin = 10.0;
  var animatedColor;
  var animatedBorder = Colors.white;
  AudioCache audioCache = AudioCache();

  bool flashOn = false;
  bool sessionOn = false;
  int sessionImageCount = 0;

  @override
  void initState() {
    super.initState();
    _initCameraController(widget.cameras.first).then((void v) {});
    setState(() {
      animatedHeight = 80.0;
      animatedMargin = 5.0;
      animatedColor = null;
      animatedBorder = Colors.white;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    setState(() {
      sessionOn = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    return !controller.value.isInitialized
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        :
        // }

        Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                // fit: StackFit.passthrough,
                children: <Widget>[
                  _cameraPreviewWidget(context),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 11.5, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "AI Birdie",
                                      style: level2softw.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              width: 45,
                              height: 45,
                              child: IconButton(
                                icon: Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  LandingPage.controller.animateToPage(3,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                              ),
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
                                child: AnimatedContainer(
                                  curve: Curves.bounceOut,
                                  duration: Duration(milliseconds: 300),
                                  margin:
                                      EdgeInsets.only(bottom: animatedMargin),
                                  height: animatedHeight,
                                  decoration: BoxDecoration(
                                    color: animatedColor,
                                    border: Border.all(
                                        width: 5.00, color: animatedBorder),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              onTap: () {
                                audioCache.play('camera_click.ogg',
                                    mode: PlayerMode.LOW_LATENCY);

                                setState(() {
                                  animatedHeight = 90;
                                  animatedMargin = 0;
                                  animatedColor = Colors.red;
                                  animatedBorder = Colors.black;
                                });
                                _onCapturePressed(context);
                              },
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          LandingPage.controller.animateToPage(
                                              0,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeInOut);
                                          // controller.dispose();
                                        },
                                        icon: Icon(
                                          Icons.dashboard,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "Dashboard",
                                        style: level2softw.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Column(
                                //   children: <Widget>[
                                //     SizedBox(
                                //       height: 10,
                                //     ),
                                //     Visibility(
                                //       visible: sessionOn,
                                //       child: AnimatedContainer(
                                //         duration: Duration(milliseconds: 300),
                                //         child: Stack(
                                //           alignment: Alignment.topRight,
                                //           children: <Widget>[
                                //             IconButton(
                                //               icon: Icon(
                                //                 Icons.photo_library,
                                //                 color: Colors.white,
                                //                 size: 30,
                                //               ),
                                //               onPressed: () {
                                //                 LandingPage.camController
                                //                     .animateToPage(1,
                                //                         duration: Duration(
                                //                             milliseconds: 300),
                                //                         curve:
                                //                             Curves.easeInOut);
                                //               },
                                //             ),
                                //             CircleAvatar(
                                //               backgroundColor: softGreen,
                                //               radius: 8,
                                //               child: Text(
                                //                 sessionImageCount.toString(),
                                //                 style: level2softw.copyWith(
                                //                     fontSize: 10,
                                //                     fontWeight:
                                //                         FontWeight.bold),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Container(
                                  width: 100,
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: (() => LandingPage.controller
                                            .animateToPage(2,
                                                duration:
                                                    Duration(milliseconds: 300),
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
                                        style: level2softw.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
        setState(() {
          // print(MediaQuery.of(context).size.aspectRatio);
          sca = MediaQuery.of(context).size.height / size.longestSide;
        });
      },

      // onChange: (size) => setState(() => sca = MediaQuery.of(context).size.height / size.longestSide),

      child: ClipRect(
        child: Transform.scale(
          scale:
              MediaQuery.of(context).size.aspectRatio <= (9 / 16) ? 1.26 : sca,
          child: Center(
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller)),
          ),
        ),
      ),
    );
  }

  void _onCapturePressed(context) async {
    // setState(() {
    //   sessionOn = true;
    //   sessionImageCount++;
    // });
    try {
      final path =
          '/storage/emulated/0/AiBirdie/Images/${DateTime.now().toString()}.jpg';

      await controller.takePicture(
        path,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageResult(File(path)),
        ),

        /**original */
        // MaterialPageRoute(
        //   builder: (context) => PreviewPage(File(path), Storage()),
        // ),
      );
      setState(() {
        animatedHeight = 80.0;
        animatedMargin = 5.0;
        animatedColor = null;
        animatedBorder = Colors.white;
      });
    } catch (e) {
      print(e);
    }
  }
}

//Measure size for responsive camera screen
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
