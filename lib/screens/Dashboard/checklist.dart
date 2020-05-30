import 'dart:io';
import 'package:aibirdie/components/not_signedIn_widget.dart';
import 'package:aibirdie/screens/Dashboard/checklist_birds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/components/storage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:aibirdie/components/dimissed_background.dart';

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final checklistFile =
      File('/storage/emulated/0/AiBirdie/Notes/checklist.txt');

  // var isChecked = [];
  var checkList = [];
  var birds = {};

  var noCheckList = true;
  bool loading = true;
  bool birdLoading = true;

  String birdInput = '';
  QuerySnapshot snapShots;

  final userChecklists = Firestore.instance
      .collection('users')
      .document(globalUserID)
      .collection('userChecklists');

  @override
  void initState() {
    // readChecklistFile();
    // for (var i = 0; i < checkList.length; i++) isChecked.add(false);
    fetchData();
    super.initState();
  }

  void fetchData() async {
    snapShots = await userChecklists.getDocuments();
    setState(() {
      checkList = snapShots.documents.map((e) => e.documentID).toList();
    });
    // checkList = value.data['userChecklists'];

    if (checkList.length > 0)
      setState(() {
        noCheckList = false;
      });

    var a = await Firestore.instance
        .collection('users')
        .document(globalUserID)
        .collection('userChecklists')
        .getDocuments();

    setState(() {
      for (var i in a.documents)
        birds.addAll({'${i.documentID}': i.data['birds']});
    });
    print("maru: $birds");

    setState(() {
      loading = false;
    });
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
      // for (var i = 0; i < checkList.length; i++) isChecked.add(false);
    });
  }

  Widget noNotesWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
        ),
      ),
    );
  }

  // Future<void> deleteCheckBirdAt(int index) async {
  //   checkList.removeAt(index);
  //   String temp = "";
  //   for (var everyCheckBird in checkList) temp = temp + everyCheckBird + "\n";
  //   await clearFile(checklistFile);
  //   await appendContent(checklistFile, temp);
  //   var value = await readContentsByLine(checklistFile);
  //   setState(() => checkList = value);
  //   if (checkList.length == 0) {
  //     print("All notes deleted");
  //     setState(() => noCheckList = true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  signedIn ? "Add new checklist" : "Save your checklists",
                  style: TextStyle(fontSize: 25, fontFamily: 'OS_semi_bold'),
                ),
                Text("Which birds would you like to see?", style: level2softdp),
              ],
            ),
            Visibility(
              visible: signedIn,
              child: FloatingActionButton(
                  backgroundColor: softGreen,
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Alert(
                      title: 'Name your checklist',
                      type: AlertType.none,
                      context: context,
                      style: AlertStyle(
                        titleStyle: level2softdp.copyWith(
                          fontSize: 25,
                        ),
                      ),
                      content: Column(
                        children: <Widget>[
                          Icon(
                            Icons.playlist_add_check,
                            size: 40,
                            color: softGreen,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: 'E.g. Mandi trip',
                                hintStyle: TextStyle(fontFamily: 'OS_regular')),
                            style: level2softdp,
                            onChanged: (newText) {
                              setState(() {
                                birdInput = newText;
                                noCheckList = false;
                              });
                            },
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          child: Text(
                            'Create',
                            style: level2softw,
                          ),
                          // radius: BorderRadius.circular(100),
                          onPressed: () async {
                            var input = birdInput.trim();
                            if (input != '') {
                              userChecklists.document('$input').setData({
                                'birds': [],
                              });

                              // Firestore.instance.collection('users').document(globalUserID).

                              setState(() {
                                checkList.add(input);
                              });

                              // await appendContent(
                              //     checklistFile, "${birdInput.trim()}\n");
                              // var value = await readContentsByLine(checklistFile);
                              // setState(() {
                              //   checkList = value;
                              //   noCheckList = false;
                              //   isChecked.add(false);
                              // });
                            } else {
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
            ),
          ],
        ),
        signedIn
            ? loading
                ? Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : noCheckList
                    ? noNotesWidget()
                    : Container(
                        height: checkList.length <= 7
                            ? (checkList.length * 110).toDouble()
                            : (checkList.length * 80).toDouble(),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: checkList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: Duration(milliseconds: 300),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Color(0xfff5f5f5),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(-6.00, -6.00),
                                            color: Color(0xffffffff)
                                                .withOpacity(0.80),
                                            blurRadius: 10,
                                          ),
                                          BoxShadow(
                                            offset: Offset(6.00, 6.00),
                                            color: Color(0xff000000)
                                                .withOpacity(0.20),
                                            blurRadius: 10,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.00),
                                      ),
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.startToEnd,
                                        onDismissed: (dismissDirection) async {
                                          await userChecklists
                                              .document('${checkList[index]}')
                                              .delete();
                                        },
                                        background: dismissedBackground(),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 2, bottom: 2, right: 15),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                      PageTransitionType.scale,
                                                  alignment:
                                                      Alignment.center,
                                                  child: CheckListBirds(
                                                    checklist: checkList[index],
                                                    birds:
                                                        birds[checkList[index]],
                                                  ),
                                                ),
                                              );

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         CheckListBirds(
                                              //       birds:
                                              //           birds[checkList[index]],
                                              //     ),
                                              //   ),
                                              // );
                                            },
                                            leading: Icon(
                                              Icons.playlist_add_check,
                                              color: softGreen,
                                            ),
                                            title: Text(
                                              "${checkList[index]}",
                                              style: level2softdp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
            : NotSignedInWidget(
                text: "Sign in to view your checklists.",
              ),
      ],
    );
  }
}
