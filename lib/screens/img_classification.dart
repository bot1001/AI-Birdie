import 'dart:io';

import 'package:aibirdie/components/bird.dart';
import 'package:aibirdie/components/buttons.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/image_result.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

class ImageClassification extends StatefulWidget {
  final Bird myBird;
  final String path;
  ImageClassification(this.myBird, this.path);

  @override
  _ImageClassificationState createState() => _ImageClassificationState();
}

File img;

class _ImageClassificationState extends State<ImageClassification> {

  @override
  void initState() { 
    img = File(widget.path);
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    'images/image_search.png',
                    width: 200,
                  ),








                  // Positioned(
                  //     top: 108,
                  //     left: 132,
                  //     child: CircularProgressIndicator(
                  //         // backgroundColor: Colors.black,

                  //         // strokeWidth: 2,

                  //         )),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     ScaleAnimatedTextKit(
              //         onTap: () {
              //           print("Tap Event");
              //         },
              //         text: ["     Identifying   ", 
              //                "Extracting features",
              //                "     Please wait   "],
              //         textStyle:
              //             TextStyle(fontSize: 25),
              //         textAlign: TextAlign.start,
              //         alignment:
              //             AlignmentDirectional.topStart // or Alignment.topLeft
              //         ),
              //   ],
              // ),
              Container(
                width: double.infinity,
                height: 150,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.lightBlueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.myBird.name,
                          style: level2w,
                        ),
                        Divider(color: Colors.black, height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Date & Time",
                              style: level1w,
                            ),
                            Text(
                              '${widget.myBird.date}, ${widget.myBird.time}',
                              style: level1w,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Location",
                              style: level1w,
                            ),
                            Text(
                              '${widget.myBird.lat == "Latitude" ? "NA" : widget.myBird.lat.substring(0, 5)}, ${widget.myBird.long == "Longitude" ? "NA" : widget.myBird.long.substring(0, 5)} (${widget.myBird.location})',
                              style: level1w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              solidButton("I D E N T I F Y   N O W", () {
                // print("${widget.path}");

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ImageResult(img),
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
