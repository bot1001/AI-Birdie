
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get appLocalPath async {
  final directory = await getApplicationDocumentsDirectory();
  // For your reference print the AppDoc directory 
  // print(directory.path);
 return directory.path;
}


Future<File> get appLocalFile async {
  final path = await appLocalPath;
  return File('$path/data.txt');
}


Future<File> appendContent(String data) async {
  final file = await appLocalFile;
  // Write the file
  return file.writeAsString(data, mode: FileMode.append);
}


// Future<File> writeContent(String data) async {
//   final file = await appLocalFile;
//   // Write the file
  
//   return file.writeAsString(data, mode: FileMode.write);
// }



Future<File> clearFile() async{
  final file = await appLocalFile;
  return file.writeAsString("", flush: true);
}



Future<List<String>> readContentsByLine() async {
  try {
    final file = await appLocalFile;
    List<String> contents = await file.readAsLines();
    return contents;
  } catch (e) {
  //   // If there is an error reading, return a default String
    return [];
  }
}