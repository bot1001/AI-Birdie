import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class Storage{

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/database.txt');
  }

  Future<File> get localNoteFile async {
    final path = await localPath;
    return File('$path/notes.txt');
  }

  Future<File> get localInfoFile async {
    final path = await localPath;
    return File('$path/info.txt');
  }


  // Future clearFile() async {
  //   final file = await localFile;
    


  // }

  Future<String> readData() async {
    try{
      final file = await localFile;
      String body = await file.readAsString();
      return body;

    }catch(e){
      return e.toString();
    }
  }

  Future<File> writeData(String data, FileMode fm) async {
    final file = await localFile;
    return file.writeAsString("\n$data", mode: fm);

  }

  Future<String> readNoteData() async {
    try{
      final file = await localNoteFile;
      String body = await file.readAsString();
      return body;

    }catch(e){
      return e.toString();
    }
  }

  Future<File> writeNoteData(String data, FileMode fm) async {
    final file = await localNoteFile;
    return file.writeAsString("\n$data", mode: fm);

  }
  Future<String> readInfoData() async {
    try{
      final file = await localInfoFile;
      String body = await file.readAsString();
      return body;

    }catch(e){
      return e.toString();
    }
  }

  Future<File> writeInfoData(String data, FileMode fm) async {
    final file = await localInfoFile;
    print("write info data ma gayu");
    return file.writeAsString("\n$data", mode: fm);
  }


}