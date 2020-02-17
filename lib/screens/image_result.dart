// import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'dart:html';

class ImageResult extends StatefulWidget {
  final File imageInputFile; 

  ImageResult(this.imageInputFile);



  @override
  _ImageResultState createState() => _ImageResultState();
}

class _ImageResultState extends State<ImageResult> {

  final String url = "https://www.google.com/";
  String classId, className;

  

  @override
  void initState()  { 
    super.initState();


    // this.getJsonData();
    //Call API here
  }

  Future<String> getJsonData() async{
    var response = await http.get(url);
    print(response.body);

    setState(() {
      // var convertDataToJson = jsonDecode(response.body);
      // classId = convertDataToJson['class_id'];
      // className = convertDataToJson['class_name'];
    });
    return "success";

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Bird name"),
      ),
    );

  }










}


