// import 'package:aibirdie/screens/history.dart';
import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:flutter/material.dart';

class ImageChip extends StatefulWidget {
  @override
  _ImageChipState createState() => _ImageChipState();
}
final Storage storage = Storage();

class _ImageChipState extends State<ImageChip> {


   String data;
  String info;

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

    print("Imagecollection: $imageCollections");
    print("Infos: $infos");

    // data.split(pattern)
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: imageCollections.length,
        itemBuilder: (BuildContext context, int index){
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

      ),
    );
  }
}
