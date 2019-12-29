// import 'dart:async';
import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/preview_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

List<CameraDescription> cameras;

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
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _cameraPreviewWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 85.00,
                    width: 85.00,
                    decoration: BoxDecoration(
                      // color: Color(0xffffffff),
                      border: Border.all(width: 5.00, color: Colors.white),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: (){
                    _onCapturePressed(context);
                  },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              File image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              // print(image.path);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PreviewPage(image.path, Storage()),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Text(
                            "Upload",
                            style: level1.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 15,),
                        IconButton(
                          onPressed: (){
                            print("object");
                            
                          },
                          icon: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30,),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: 100,
                    // ),
                    Container(
                      width: 60 ,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () { 
                            },
                            icon: Icon(
                              Icons.audiotrack,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Text(
                            "Audio",
                            style: level1.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<String> takeImage() async {
  //   if (!controller.value.isInitialized) {
  //     // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Error: select a camera first."),));
  //     // showInSnackBar('Error: select a camera first.');
  //     print("Error: select a camera first.");
  //     return null;
  //   }
  //   final Directory extDir = await getApplicationDocumentsDirectory();
  //   final String dirPath = '${extDir.path}/Pictures/flutter_test';
  //   await Directory(dirPath).create(recursive: true);
  //   final String filePath = '$dirPath/${timestamp()}.jpg';

  //   if (controller.value.isTakingPicture) {
  //     // A capture is already pending, do nothing.
  //     return null;
  //   }

  //   try {
  //     await controller.takePicture(filePath);
  //   } on CameraException catch (e) {
  //     _showCameraException(e);
  //     return null;
  //   }
  //   return filePath;
  // }

  void _showCameraException(CameraException e) {
    print("Error: ${e.code}\n${e.description}");
    // showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.ultraHigh);

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

    return CameraPreview(controller);
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
          builder: (context) => PreviewPage(path, Storage()),
        ),
      );

      // Scaffold.of(context).showSnackBar(new SnackBar(
      //                       content:
      //                           new Text("Photo clicked"),
      //                       action: SnackBarAction(
      //                         label: "OK",
      //                         onPressed: () {},
      //                       ),
      //                       behavior: SnackBarBehavior.floating,
      //                     ));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PreviewImageScreen(imagePath: path),
      //   ),
      // );
    } catch (e) {
      print(e);
    }
  }
}
