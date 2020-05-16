import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AiBirdieAudioClassification {
  File inputFile;
  String url = 'https://audio-27.el.r.appspot.com/predict';
  AiBirdieAudioClassification({this.inputFile});
  Future<dynamic> predict() async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      inputFile.path,
      filename: inputFile.path.split("/").last,
    ));
    var stream = await request.send();
    var response = await http.Response.fromStream(stream);
    var result = await json.decode(response.body);
    return result;
  }
}
