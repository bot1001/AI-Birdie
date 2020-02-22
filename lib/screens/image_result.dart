// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

class ImageResult extends StatefulWidget {
  final File imageInputFile;

  ImageResult(this.imageInputFile);

  @override
  _ImageResultState createState() => _ImageResultState();
}

class _ImageResultState extends State<ImageResult> {
  final String url = "https://www.google.com/";
  // String classId, className;

  var bytes;
  String base_64;
  var file;

  @override
  void initState() {
    super.initState();

    bytes = widget.imageInputFile.readAsBytesSync();
    base_64 = base64Encode(bytes);
    print(base_64);

    // this.getJsonData();
    //Call API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("label"),
      ),
    );
  }
}
