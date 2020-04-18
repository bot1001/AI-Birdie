// import 'dart:io';

import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import 'package:modal_progress_hud/modal_progress_hud.dart';
final Storage storage = Storage();

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // Storage storage;
  String data;
  String info;
  // bool _hud = false;
  static var imageCollections = [];
  static var infos = [];

  @override
  void initState() {
    storage.readData().then((String value) {
      setState(() {
        value = value.trim();
        if (value != "") {
          data = value;
          data = data.trim();
          imageCollections = data.split("\n");

        }
        // _hud = false;
      });
    });

    storage.readInfoData().then((String value) {
      setState(() {
        value = value.trim();
        if (value != "") {
          info = value;
          // info = data.trim();
          infos = data.split("\n");
        }
        // _hud = false;
      });
    });

    // print("\nInfos************");
    for(String i in infos){
      print(i);
    }









    // data.split(pattern)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
    child: imageCollections.isNotEmpty
        ? Container(
          // padding: EdgeInsets.only(top: 50),
          child: Stack(
            children: <Widget>[
              ListView.builder(
                // reverse: true,
                  // dragStartBehavior: DragStartBehavior.down,

                  itemCount: imageCollections.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.file(
                                  File(imageCollections[index]),
                                  width: 50,
                                ),
                                // Text(imageCollections[index]),

                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Bird name"),
                                    // Text(_name.toString()),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text("Date: "),
                                        // Text(_date.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Time: "),
                                        // Text(_time.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Location: "),
                                        // Text(_location.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  imageCollections.removeAt(index);
                                  storage.writeData("", FileMode.write);
                                  for (String i in imageCollections) {
                                    storage.writeData(i, FileMode.append);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      // ),
                    );
                  },

                  // Text(_path.toString()),
                  // Text("1")
                ),
                                    // Positioned(
                                    //   top: 0,
                                    //   left: 10,
                                    //   child: Text("   History", style: heading1,)),

            ],
          ),
        )
        : Container(
            height: 300.00,
            width: 300.00,
            decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              boxShadow: [
                BoxShadow(
                  offset: Offset(30.00, 30.00),
                  color: Color(0xff3754aa).withOpacity(0.10),
                  blurRadius: 80,
                ),
              ],
              borderRadius: BorderRadius.circular(39.00),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'images/cage.png',
                      width: 200,
                    ),
                    Text(
                      "🕊",
                      style: heading1.copyWith(fontSize: 50),
                    ),
                  ],
                ),
                Text(
                  'All birds are gone..',
                  style: level2,
                )
              ],
            ),
            // child: Text("data"),
          ));
  }
}

// Future<String> getNamePreference(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String value = prefs.getString(key);
//   return value;
// }

// class Bird {
//   String imagePath, name, date, time, location;
// }
