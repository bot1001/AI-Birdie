// import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/hardware/image.dart';
import 'dart:io';
import 'package:aibirdie/components/bird.dart';
import 'package:aibirdie/screens/img_classification.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

// import 'package:aibirdie/components/buttons.dart';
// import 'package:aibirdie/components/icons.dart';
import 'package:aibirdie/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:aibirdie/components/storage.dart';

String currentDT;
Bird myBird;

class PreviewPage extends StatefulWidget {
  // final String path;
  final File img;
  final Storage storage;

  PreviewPage(this.img, this.storage);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
    currentDT = DateTime.now().toString();
    _dateController.text =
        "${currentDT.substring(8, 10)}-${currentDT.substring(5, 7)}-${currentDT.substring(0, 4)}";
    _timeController.text = "${currentDT.substring(11, 16)}";

    myBird = Bird();
  }

  String state;

  // File imageFile;
  String lat = "Latitude", long = "Longitude";

  var _nameController = TextEditingController();
  var _dateController = TextEditingController();
  var _timeController = TextEditingController();
  var _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Preview",
                    style: heading1.copyWith(fontSize: 25),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // borderSide: BorderSide(
                    //     style: BorderStyle.solid,
                    //     color: Colors.black,
                    //     width: 1.5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: <Widget>[
                          Text("Cancel",
                              style: level1.copyWith(color: Colors.white)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0)),
                  height: 240,
                  // child: Image
                  child: Image.file(File(widget.img.path))),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Enter bird details:',
                    style: heading1.copyWith(fontSize: 25),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'For eg. Dove',
                  labelText: 'Enter bird name',
                  labelStyle: level1,
                  hintStyle: level1,
                ),
                controller: _nameController,
                style: level1,
              ),
              DateTimeField(
                style: level1,
                decoration: InputDecoration(labelText: "Select date", labelStyle: level1),
                controller: _dateController,
                initialValue: DateTime.now(),
                format: DateFormat("dd-MM-yyyy"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              DateTimeField(
                style: level1,
                controller: _timeController,
                decoration: InputDecoration(labelText: "Select time", labelStyle: level1),
                initialValue: DateTime.now(),
                format: DateFormat("hh:mm"),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Bird spot details:',
                    style: heading1.copyWith(fontSize: 25),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(lat, style: level1,),
                  Text(long, style: level1,),
                  IconButton(
                    icon: Icon(Icons.gps_fixed),
                    onPressed: () => getLocation(),
                  ),
                ],
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'For eg. Mandi, HP',
                  hintStyle: level1,
                  labelText: 'Enter location(Optional)',
                  labelStyle: level1
                ),
                style: level1,
              ),
              SizedBox(
                height: 25,
              ),
              // Placeholder(),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    // print("object");
                    // saveData();
                    // print("Path is: " + widget.path);
                    if (_nameController.text == "" ||
                        _dateController.text == "" ||
                        _timeController.text == "") {
                      Alert(
                        // closeFunction: (){
                        //   Navigator.pop(context);
                        // },
                        context: context,
                        type: AlertType.error,
                        title: "Invalid data",
                        style: AlertStyle(
                          titleStyle: heading1,
                          descStyle: level1,
                        ),
                        desc: "Please fill all the required fields",
                        buttons: [
                          DialogButton(
                            color: Colors.green,
                            child: Text(
                              "OKAY",
                              style: level1w.copyWith(fontSize: 25),
                            ),
                            onPressed: () {

                              Navigator.pop(context);
                            },
                            width: 120,
                          ),
                        ],
                      ).show();
                    } else {
                      myBird.name = _nameController.text;
                      myBird.date = this._dateController.text;
                      myBird.time = this._timeController.text;
                      myBird.lat = this.lat;
                      myBird.long = this.long;
                      myBird.location = _locationController.text == "" ? "Unknown" : _locationController.text;

                      // print("Name: ${myBird.name}");
                      // print("Date: ${myBird.date}");
                      // print("Time: ${myBird.time}");
                      // print("Latitude: ${myBird.lat}");
                      // print("Longitude: ${myBird.long}");
                      // print("Location: ${myBird.location}");

                      //Save above data to a file



                      widget.storage.writeData(widget.img.path, FileMode.append);


                      widget.storage.writeInfoData("${myBird.name}@${myBird.date}@${myBird.time}@${myBird.lat}@${myBird.long}@${myBird.location}", FileMode.append);

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImageClassification(myBird, widget.img),
                        ),
                      );
                    }
                    // Navigator.of(context).pop();
                  },
                  // color: Color(0xff047bfe),
                  color: myBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("S A V E  &  N E X T",
                            style: level1.copyWith(color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // void saveData() {
  //   print(widget.path);
  //   String birdName = _nameController.text;
  //   String dateSpotted = _dateController.text;
  //   String timeSpotted = _timeController.text;
  //   String location = _locationController.text;

  //   saveNamePreference("name", birdName);
  //   saveNamePreference("path", widget.path);
  //   saveNamePreference("date", dateSpotted);
  //   saveNamePreference("time", timeSpotted);
  //   saveNamePreference("location", location);
  // }

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.longitude.toString();
      long = position.latitude.toString();
    });
  }
}

// Future saveNamePreference(String key, String value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(key, value);
// }
