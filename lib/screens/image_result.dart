// import 'dart:convert';
// import 'dart:convert';
import 'dart:io';
// import 'package:aibirdie/screens/img_classification.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

import './aibirdie_image_api/aibirdie_image_classification.dart';
import './aibirdie_image_api/generated/image_classification.pb.dart';

// import 'package:http/http.dart';



class ImageResult extends StatefulWidget {
  final File imageInputFile;
  

  ImageResult(this.imageInputFile);

  @override
  _ImageResultState createState() => _ImageResultState();
}

class _ImageResultState extends State<ImageResult> {

  AiBirdieImageClassification classifier;
  var response;
  

  @override
  void initState() {
    super.initState();

    classifier = AiBirdieImageClassification('35.232.129.172');
    classifier.predict(widget.imageInputFile.path).then((value){
      
      print('Response: $value');
      setState(() {
        response = value;
      });

    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$response"),
      ),
    );
  }
}
