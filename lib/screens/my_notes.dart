import 'dart:io';

import 'package:aibirdie/components/dimissed_background.dart';
import 'package:aibirdie/components/storage_1.dart';
import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyNotes extends StatefulWidget {
  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  final controller = TextEditingController();
  final notesFile = File('/storage/emulated/0/AiBirdie/Notes/notes.txt');
  var noNotes = true;

  var _notes = [];

  @override
  void initState() {
    super.initState();
    readNotesFile();
  }

  void readNotesFile() async {

    var value = await readContentsByLine(notesFile);
    setState(() {
      if (value.length == 0) {
        noNotes = true;
      } else {
        _notes = value;
        noNotes = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Notes",
                    style: TextStyle(fontSize: 35, fontFamily: 'OS_semi_bold'),
                  ),
                  Text("Save your notes here", style: level2softdp),
                ],
              ),
              Icon(
                FontAwesomeIcons.edit,
                size: 30,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: softGreen,
            boxShadow: [
              BoxShadow(
                offset: Offset(-6.00, -6.00),
                color: Color(0xffffffff).withOpacity(0.80),
                blurRadius: 10,
              ),
              BoxShadow(
                offset: Offset(6.00, 6.00),
                color: Color(0xff000000).withOpacity(0.20),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(15.00),
          ),
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: TextField(
              controller: controller,

              style: level2softw,
              cursorColor: darkPurple,
              decoration: InputDecoration(
                hintText: "Add a new note...",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              // onChanged: ((newText) => setState(() => _textInput = newText)),
              onSubmitted: (newText) async {
                controller.clear();
                if (newText.trim() != '') {
                  await appendContent(notesFile, "${newText.trim()}\n");
                  var value = await readContentsByLine(notesFile);
                  setState(() {
                    _notes = value;
                    noNotes = false;
                  });
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    action: SnackBarAction(label: 'OK', onPressed: (){}),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: darkPurple,
                    behavior: SnackBarBehavior.floating,
                      content: Text(
                    'Empty note cannot be added to the list.',
                    style: level2softw,
                  )));
                }

                // Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Divider(
          height: 30,
          // thickness: 1,
          color: darkPurple,
        ),
        noNotes == true
            ? noNotesWidget()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-6.00, -6.00),
                          color: Color(0xffffffff).withOpacity(0.80),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          offset: Offset(6.00, 6.00),
                          color: Color(0xff000000).withOpacity(0.20),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.00),
                    ),
                    child: Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: dismissedBackground(),
                      onDismissed: ((dismissDirection) => deleteNoteAt(index)),
                      key: UniqueKey(),
                      child: ListTile(
                        // leading: Text("${index + 1}"),
                        title: Text(_notes[index]),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: (() => deleteNoteAt(index)),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }

  Future<void> deleteNoteAt(int index) async {
    _notes.removeAt(index);
    String temp = "";
    for (var everyNote in _notes) temp = temp + everyNote + "\n";
    await clearFile(notesFile);
    await appendContent(notesFile, temp);
    var value = await readContentsByLine(notesFile);
    setState(() => _notes = value);
    if (_notes.length == 0) {
      print("All notes deleted");
      setState(() => noNotes = true);
    }
  }

  Widget noNotesWidget() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          boxShadow: [
            BoxShadow(
              offset: Offset(-6.00, -6.00),
              color: Color(0xffffffff).withOpacity(0.80),
              blurRadius: 10,
            ),
            BoxShadow(
              offset: Offset(6.00, 6.00),
              color: Color(0xff000000).withOpacity(0.20),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(15.00),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        // color: Colors.red,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.text_fields,
              size: 40,
              color: softGreen,
            ),
            Column(
              children: <Widget>[
                Text(
                  "You have not added any notes yet.",
                  style: level2softdp,
                ),
              ],
            ),
          ],
        )));
  }
}
