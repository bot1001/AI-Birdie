import 'package:flutter/material.dart';

class MyNotes extends StatefulWidget {
  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("my notes", style: TextStyle(
          fontSize: 35
        ),),
      ),
      
    );
  }
}