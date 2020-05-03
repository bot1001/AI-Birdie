// import 'package:aibirdie/screens/history.dart';
import 'dart:io';

import 'package:aibirdie/components/storage.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/chips/image_full.dart';
import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

class ImageChip extends StatefulWidget {
  @override
  _ImageChipState createState() => _ImageChipState();
}

final Storage storage = Storage();

class _ImageChipState extends State<ImageChip> {
  String data;
  String info;

  var images = [];

  static var imageCollections = [];
  static var infos = [];

  @override
  void initState() {
    readImages();

    // storage.readData().then((String value) {
    //   setState(() {
    //     value = value.trim();
    //     if (value != "") {
    //       data = value;
    //       data = data.trim();
    //       imageCollections = data.split("\n");
    //     }
    //     // _hud = false;
    //   });
    // });

    // storage.readInfoData().then((String value) {
    //   setState(() {
    //     value = value.trim();
    //     if (value != "") {
    //       info = value;
    //       // info = data.trim();
    //       infos = data.split("\n");
    //     }
    //     // _hud = false;
    //   });
    // });

    // print("Imagecollection: $imageCollections");
    // print("Infos: $infos");

    // data.split(pattern)
    super.initState();
  }

  void readImages() async {
    var myPath = '/storage/emulated/0/AiBirdie/Images';
    Directory imgDir = Directory(myPath);
    var temp = imgDir.list();
    images = await temp.toList();
    setState(() {});
  }

  void deleteImage(index) {
    File f = images[index];
    f.delete();
    setState(() {
      readImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return images.length == 0
        ? Container(
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
                  Icons.photo_album,
                  size: 40,
                  color: softGreen,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "No images to show.",
                      style: level2softdp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Click on",
                          style: level2softdp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: softGreen,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        Text(
                          "to take one.",
                          style: level2softdp,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  // height: 200,
                  margin: EdgeInsets.only(bottom: 15),
                  // height: 300,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageFull(inp: images[index],),
                            ),
                          );
    









                          // Alert(
                          //     context: context,
                          //     title: "",
                          //     style: AlertStyle(
                          //         animationDuration:
                          //             Duration(milliseconds: 300),
                          //         animationType: AnimationType.grow,
                          //         descStyle: level2softdp,
                          //         titleStyle:
                          //             level1dp.copyWith(fontSize: 25)),
                          //     content: Image.file(
                          //       images[index],
                          //     ),
                          //     buttons: [
                          //       DialogButton(
                          //         child: Text(
                          //           "OK",
                          //           style: level1w,
                          //         ),
                          //         color: softGreen,
                          //         onPressed: () => Navigator.pop(context),
                          //         width: 120,
                          //       )
                          //     ]).show();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 5.0,
                            // color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: Hero(
                              tag: '${images[index].path}',
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: FileImage(images[index]),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => deleteImage(index),
                      ),
                    ],
                  )
                  // ),
                  );
            },
          );
  }
}
