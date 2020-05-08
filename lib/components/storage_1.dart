import 'dart:io';

// import 'package:path_provider/path_provider.dart';

final notesFile = File('/storage/emulated/0/AiBirdie/Notes/notes.txt');

Future<File> appendContent(String data) async {
  return notesFile.writeAsString(data, mode: FileMode.append);
}

Future<File> clearFile() async {
  return notesFile.writeAsString("", flush: true);
}

Future<List<String>> readContentsByLine() async {
  try {
    List<String> contents = await notesFile.readAsLines();
    return contents;
  } catch (e) {
    //   // If there is an error reading, return a default String
    return [];
  }
}
