import 'dart:io';

import 'package:aibirdie/components/bird.dart';
import 'package:aibirdie/components/buttons.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/image_result.dart';
import 'package:flutter/material.dart';

class ImageClassification extends StatefulWidget {
  final Bird myBird;
  // final String path;
  final File img;
  ImageClassification(this.myBird, this.img);

  @override
  _ImageClassificationState createState() => _ImageClassificationState();
}

class _ImageClassificationState extends State<ImageClassification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Classification",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'images/image_search.png',
                width: 200,
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-6.00, -6.00),
                      color: Colors.white.withOpacity(0.80),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      offset: Offset(6.00, 6.00),
                      color: Colors.black.withOpacity(0.20),
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.00),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.myBird.name,
                        style: level2softdp.copyWith(fontSize: 25),
                      ),
                      Divider(color: Colors.black, height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Date & Time",
                            style: level2softdp,
                          ),
                          Text(
                            '${widget.myBird.date}, ${widget.myBird.time}',
                            style: level2softdp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Location",
                            style: level2softdp,
                          ),
                          Text(
                            '${widget.myBird.lat == "Latitude" ? "NA" : widget.myBird.lat.substring(0, 5)}, ${widget.myBird.long == "Longitude" ? "NA" : widget.myBird.long.substring(0, 5)} (${widget.myBird.location})',
                            style: level2softdp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              solidButton("I D E N T I F Y   N O W", () {
                // print("${widget.path}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageResult(widget.img),
                  ),
                );

                //Call API here

                // Alert(
                //   type: AlertType.warning,
                //   title: "API not connected",
                //   desc: "Smit is still working on API",
                //   context: context,
                //   buttons: [
                //     DialogButton(
                //             color: Colors.green,
                //             child: Text(
                //               "OKAY",
                //               style:
                //                   TextStyle(color: Colors.white, fontSize: 20),
                //             ),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //             width: 120,
                //           ),
                //   ]
                // ).show();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
