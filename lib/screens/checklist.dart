import 'dart:io';

import 'package:aibirdie/components/dimissed_background.dart';
import 'package:aibirdie/components/storage_1.dart';
import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final checklistFile =
      File('/storage/emulated/0/AiBirdie/Notes/checklist.txt');

  var isChecked = [];
  var checkList = [];
  var noCheckList = true;

  String birdInput = '';

  @override
  void initState() {
    readChecklistFile();
    // for (var i = 0; i < checkList.length; i++) isChecked.add(false);

    super.initState();
  }

  void readChecklistFile() async {
    var value = await readContentsByLine(checklistFile);
    setState(() {
      if (value.length == 0) {
        noCheckList = true;
      } else {
        checkList = value;
        noCheckList = false;
      }
      for (var i = 0; i < checkList.length; i++) isChecked.add(false);
    });
  }

  Widget noNotesWidget() {
    return Container(
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
        height: MediaQuery.of(context).size.height * 0.3,
        // color: Colors.red,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.playlist_add_check,
              size: 40,
              color: softGreen,
            ),
            Column(
              children: <Widget>[
                Text(
                  "You have watched all the birds you added.",
                  style: level2softdp,
                ),
              ],
            ),
          ],
        )));
  }

  Future<void> deleteCheckBirdAt(int index) async {
    checkList.removeAt(index);
    String temp = "";
    for (var everyCheckBird in checkList) temp = temp + everyCheckBird + "\n";
    await clearFile(checklistFile);
    await appendContent(checklistFile, temp);
    var value = await readContentsByLine(checklistFile);
    setState(() => checkList = value);
    if (checkList.length == 0) {
      print("All notes deleted");
      setState(() => noCheckList = true);
    }
  }

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
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Alert(
                      title: '',
                      context: context,
                      content: Column(
                        children: <Widget>[
                          Text(
                            "Write a bird name",
                            style: level2softdp.copyWith(fontSize: 25),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: 'E.g. Blue Jay',
                                hintStyle: TextStyle(fontFamily: 'OS_regular')),
                            style: level2softdp,
                            onChanged: (newText) {
                              setState(() {
                                birdInput = newText;
                              });
                            },
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          child: Text(
                            'Add',
                            style: level2softw,
                          ),
                          onPressed: () async {
                            if (birdInput.trim() != '') {
                              await appendContent(
                                  checklistFile, "${birdInput.trim()}\n");
                              var value =
                                  await readContentsByLine(checklistFile);
                              setState(() {
                                checkList = value;
                                noCheckList = false;
                                isChecked.add(false);
                              });
                            } else {
                              print('hahaha');
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  action: SnackBarAction(
                                      label: 'OK', onPressed: () {}),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: darkPurple,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'You entered nothing.',
                                    style: level2softw,
                                  )));
                            }
                            Navigator.of(context).pop();
                          },
                          color: softGreen,
                        )
                      ],
                    ).show();
                  }),
            ],
          ),
        ),
        noCheckList == true
            ? noNotesWidget()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: checkList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 15),
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
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (dismissDirection) {
                        deleteCheckBirdAt(index);
                      },
                      background: dismissedBackground(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2, right: 15),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                activeColor: softGreen,
                                value: isChecked[index],
                                onChanged: (checkBoxStatus) {
                                  setState(() {
                                    isChecked[index] = checkBoxStatus;
                                    // wantToWatch.removeAt(index);
                                  });
                                }),
                            Text(
                              "${checkList[index]}",
                              style: level2softdp.copyWith(
                                  decoration: isChecked[index]
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            Spacer(),
                            Visibility(
                                visible: isChecked[index],
                                child: Text('Watched')),
                            // SizedBox(width: 15,),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ],
    );
  }
}
