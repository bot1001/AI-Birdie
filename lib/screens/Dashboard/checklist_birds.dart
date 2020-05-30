import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class CheckListBirds extends StatefulWidget {
  final List birds;
  final String checklist;
  CheckListBirds({this.birds, this.checklist});

  @override
  _CheckListBirdsState createState() => _CheckListBirdsState();
}

class _CheckListBirdsState extends State<CheckListBirds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checklist ${widget.checklist}",
          style: level2softw,
        ),
      ),
      body: Container(
        child: Center(
          child: Text("${widget.birds.toString()}"),
        ),
      ),
    );
  }
}
