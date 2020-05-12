import 'dart:convert';
import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:mime/mime.dart';

class AiBirdieAudioClassification {
  String url = 'https://audio-27.el.r.appspot.com/predict';

  File inputFile;
  AiBirdieAudioClassification({this.inputFile});

  Future<Map<String, dynamic>> predict() async {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    final file = await http.MultipartFile.fromPath(
      'audio[0]',
      inputFile.path,
    );

    print(inputFile.path);

    request.files.add(file);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final Map<String, dynamic> res = json.decode(response.body); 

      return res;
  }
}
