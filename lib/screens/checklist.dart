import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}
class _CheckListState extends State<CheckList> {
  var wantToWatch = [];
  var watched = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Checklist",
                    style: TextStyle(fontSize: 35, fontFamily: 'OS_semi_bold'),
                  ),
                  Text("Which birds would you like to see?",
                      style: level2softdp),
                ],
              ),
              FloatingActionButton(
                
                backgroundColor: softGreen,
                child: Icon(Icons.add,),
                onPressed: () {}),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: double.infinity,
          color: Colors.red,
          child: Text("Want to watch"),
        ),
      ],
    );
  }
}
