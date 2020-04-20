
import 'package:aibirdie/constants.dart';
// import 'package:aibirdie/screens/add_note.dart';
import 'package:flutter/material.dart';

class MyNotes extends StatefulWidget {
  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {

  String _textInput;

  var _notes = [
    "This is note 1",
    "This is note 2",
    "This is note 3",
    "This is note 4",
   
  ];

  @override
  void initState() {
    super.initState();
  }

  // int _notesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Notes",
                    style: TextStyle(fontSize: 35, fontFamily: 'OS_semi_bold'),
                  ),
                  Text("Save your notes here", style: level2softdp),
                ],
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(),
                child: RaisedButton(
                  color: darkPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Container(
      color: Color(0xFF757575),

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Make a note',
              textAlign: TextAlign.center,
              style: level2softdp.copyWith(fontSize: 30),
            ),
            TextField(
              textAlign: TextAlign.center,              
              style: level2softdp,
              cursorColor: darkPurple,
              decoration: InputDecoration(
                hintText: "Write something here"),
                onChanged: ((newText)=> setState(()  => _textInput = newText)           ),
            ),
            SizedBox(
              height: 20,
            ),

            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                print(_textInput);
              },
              padding: EdgeInsets.symmetric(vertical: 15),
              color: softGreen,
              child: Text(
                "Add",
                style: level1w.copyWith(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
                      },
                    );
                  },
                  child: Text(
                    "Add note",
                    style: level2softw,
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _notes.length,
            itemBuilder: (BuildContext context, int index){
              return         Container(
                margin: EdgeInsets.only(bottom: 15),
          // height: 300,
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
          ),

          child: ListTile(
            leading: Text("${index+1}"),
            title: Text(_notes[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: (){
                setState(() {
                  _notes.removeAt(index);
                  
                });
              },
            ),
          ),
        );

            },
          ),
        ),

      ],
    );
  }
}
