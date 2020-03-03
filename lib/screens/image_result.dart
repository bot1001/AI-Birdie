// import 'dart:convert';
// import 'dart:convert';
// import 'dart:convert';
// import 'dart:convert';
import 'dart:io';
// import 'package:aibirdie/screens/img_classification.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/aibirdie_image_api/generated/image_classification.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:http/http.dart';

import './aibirdie_image_api/aibirdie_image_classification.dart';
import './aibirdie_image_api/generated/image_classification.pb.dart';

// import 'package:http/http.dart';

class ImageResult extends StatefulWidget {
  final File imageInputFile;
  final String serverIP = '35.232.129.172';

  ImageResult(this.imageInputFile);

  @override
  _ImageResultState createState() => _ImageResultState();
}

class _ImageResultState extends State<ImageResult> {
  AiBirdieImageClassification classifier;
  var response;
  ImageClassificationResponse result;

  bool _showSpinner = false;

  var labels = [];
  var accuracy = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _showSpinner = true;
    });
    classifier = AiBirdieImageClassification(widget.serverIP);
    classifier.predict(widget.imageInputFile.path).then((value) {
      result = value;
      // print('RRRRRR:  \n\n ${result.results}');

      var response = result.results;
      // print(a);
      setState(() {
        response.forEach((f) {
          labels.add(f.label);
          accuracy.add('${(f.percent*100).toString().substring(0,5)} %');
        });
        _showSpinner = false;
      });

      // response.toString().tr
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        // color: darkPurple,
        progressIndicator: CircularProgressIndicator(),

        inAsyncCall: _showSpinner,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Results",
                      style: level2softg.copyWith(fontSize: 35, fontFamily: 'OS_semi_bold'),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 200),
                itemCount: labels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${index + 1}",
                                style: level2softdp.copyWith(fontSize: 25),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    labels[index],
                                    style: level2softdp,
                                  ),
                                  Text(
                                    accuracy[index],
                                    style: level2softdp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                      height: 70,
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
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
