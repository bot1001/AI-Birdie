// import 'dart:convert';
// import 'dart:convert';
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
  @override
  void initState() {
    super.initState();


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
