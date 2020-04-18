// import 'package:aibirdie/screens/history.dart';
import 'package:flutter/material.dart';

class ImageChip extends StatefulWidget {
  @override
  _ImageChipState createState() => _ImageChipState();
}

class _ImageChipState extends State<ImageChip> {

  var myList = [
    '1',
    '2',
    '3',
    '1',
    '2',
    '3',
    '1',
    '2',
    '3',

  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Text(myList[index]),
            trailing: IconButton(icon: Icon(Icons.add), onPressed: ()=> print("asv $index")),
          );
        },

      ),
    );
  }
}
