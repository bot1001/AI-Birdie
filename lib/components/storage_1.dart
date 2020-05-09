import 'dart:io';

// import 'package:path_provider/path_provider.dart';


Future<File> appendContent(File file, String data) async {
  return file.writeAsString(data, mode: FileMode.append);
}

Future<File> clearFile(File file) async {
  return file.writeAsString("", flush: true);
}

Future<List<String>> readContentsByLine(File file) async {
  try {
    List<String> contents = await file.readAsLines();
    return contents;
  } catch (e) {
    //   // If there is an error reading, return a default String
    return [];
  }
}
