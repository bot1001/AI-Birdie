import 'dart:io';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aibirdie/APIs/aibirdie_image_api/aibirdie_image_classification.dart';
import 'package:aibirdie/APIs/aibirdie_image_api/generated/image_classification.pbgrpc.dart';

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

  bool _showSpinner = true;

  var labels = [];
  var accuracy = [];

  @override
  void initState() {
    // Timer(Duration(seconds: 2), () {
    //   setState(() {
    //     _showSpinner = false;
    //     labels = [
    //       'Black And White Warbler',
    //       'Baird Sparrow',
    //       'Brown Creeper',
    //       'Evening Grosbeak',
    //       'Heermann Gull'
    //     ];
    //     accuracy = ['78%', '11%', '4%', '2%', '0.5%'];


    //   });
    // });
    super.initState();

    /**original */
    classifier = AiBirdieImageClassification(widget.serverIP);
    print('aaama gayu che aa');
    classifier.predict(widget.imageInputFile.path).then((value) {
      result = value;
      var response = result.results;
      setState(() {
        response.forEach((f) {
          labels.add(f.label);
          accuracy.add('${(f.percent * 100).toString().substring(0, 5)} %');
        });
        _showSpinner = false;
      });

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
                      style: level2softg.copyWith(
                          fontSize: 35, fontFamily: 'OS_semi_bold'),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 200),
                itemCount: labels.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      var show = Alert(
                          style: AlertStyle(
                              titleStyle: level2softdp.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          title: 'Black And White Warbler',
                          type: AlertType.info,
                          content: Column(
                            children: <Widget>[
                              Text(
                                "The black-and-white warbler is a species of New World warbler, and the only member of its genus, Mniotilta. It breeds in northern and eastern North America and winters in Florida, Central America, and the West Indies down to Peru. This species is a very rare vagrant to western Europe.",
                                style: level2softdp,
                                textAlign: TextAlign.justify,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Learn more",
                                      style: level2softdp.copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          context: context,
                          buttons: [
                            DialogButton(
                                color: softGreen,
                                child: Text(
                                  "OK",
                                  style: level2softw,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ]);
                      show.show();
                    },
                    child: Container(
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
                        margin:
                            EdgeInsets.only(bottom: 20, left: 30, right: 30),
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
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
