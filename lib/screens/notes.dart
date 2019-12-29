// import 'package:aibirdie/screens/add_note.dart';
// import 'dart:io';

import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

final Storage storage = Storage();

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  String data;
  static var desc = [];

  @override
  void initState() {
    storage.readNoteData().then((String value) {
      setState(() {
        value = value.trim();
        if (value != "") {
          data = value;
          data = data.trim();
          desc = data.split("\n");
        }
        // _hud = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: desc.isNotEmpty
          ? Center(
              child: ListView.builder(
                itemCount: desc.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(desc[index]),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            desc.removeAt(index);
                            storage.writeNoteData("", FileMode.write);
                            for (String i in desc) {
                              storage.writeNoteData(i, FileMode.append);
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Container(
                height: 209.00,
                width: 209.00,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("🙌", style: heading1,),
                    Text(
                      "No notes",
                      style: heading1,
                    ),
                   
                        Text("Click on button below\nto add a new one.", textAlign: TextAlign.center,),
                  ],
                )),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(30.00, 30.00),
                      color: Color(0xff3754aa).withOpacity(0.16),
                      blurRadius: 80,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(42.00),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Color(0xFF757575),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Add Note',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      TextField(
                          cursorColor: Colors.black,
                          // autofocus: true,
                          textAlign: TextAlign.center,
                          onChanged: (newText) {
                            data = newText;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        onPressed: () {
                          storage.writeNoteData(data, FileMode.append);
                          storage.readNoteData().then((String value) {
                            setState(() {
                              value = value.trim();
                              data = value;
                              data = data.trim();
                              desc = data.split("\n");

                              // _hud = false;
                            });
                          });

                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: myBlue,
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
