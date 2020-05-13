// import 'dart:convert';
import 'dart:io';
// import 'package:flutter/cupertino.dart';


class AiBirdieAudioClassification {
  // ff.
  File inputFile;
  String url = 'https://audio-27.el.r.appspot.com/predict';

  AiBirdieAudioClassification({this.inputFile});

  Future<String>  predict() async {


    return "abc";

  }



  // Future<Map<String, dynamic>> predict() async {
  //   final request = http.MultipartRequest('POST', Uri.parse(url));

  //   final file = await http.MultipartFile.fromPath(
  //     'audio[0]',
  //     inputFile.path,
  //   );

  //   request.files.add(file);

  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);

  //     final Map<String, dynamic> res = json.decode(response.body); 

  //     return res;
  // }
}
