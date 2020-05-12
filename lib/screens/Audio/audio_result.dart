import 'dart:io';
// import 'dart:async';
import 'package:aibirdie/APIs/aibirdie_audio_api/request.dart';
// import 'package:aibirdie/screens/Audio/audio_identify.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AudioResult extends StatefulWidget {
  final File file;
  AudioResult(this.file);
  @override
  AudioResultState createState() => AudioResultState();
}

class AudioResultState extends State<AudioResult> {
  bool _showSpinner = true;
  var labels = [];
  var accuracy = [];
  AiBirdieAudioClassification abac;


  @override
  void initState() {

    // Timer(Duration(seconds: 2), (){
    //   setState(() {
    //     _showSpinner = false;
    //     labels = ['Rock Bunting','Chestnutcrowned Laughingthrush','Bspotted Nutcracker'];
    //     accuracy = ['90%','89.02%','85.65%'];
    //   });
    // });

    predictBird();


    super.initState();
  }












  void predictBird() async {
    abac = AiBirdieAudioClassification(inputFile: widget.file); 
    final Map<String, dynamic> aa = await abac.predict();
    print('AAAA: $aa');
  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
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
                          title: 'Rock Bunting',
                          type: AlertType.info,
                          content: Column(
                            children: <Widget>[
                              Text(
                                "It breeds in northwest Africa, southern Europe east to central Asia, and the Himalayas.This bird is 16 cm in length. The breeding male has chestnut upperparts, unmarked deep buff underparts, and a pale grey head marked with black striping. The female rock bunting is a washed-out version of the male, with paler underparts, a grey-brown back and a less contrasted head. The juvenile is similar to the female, but with a streaked head.The rock bunting breeds in open dry rocky mountainous areas.",
                                style: level2softdp,
                                textAlign: TextAlign.justify,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Learn more", style: level2softdp.copyWith(color: Colors.blue, decoration: TextDecoration.underline,)),
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
