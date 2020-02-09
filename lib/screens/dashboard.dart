// import 'dart:io';

import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/history.dart';
import 'package:aibirdie/screens/notes.dart';
import 'package:aibirdie/screens/v_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedPage = 0;
  final _pageOptions = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Bird count"),
          Text("Birds identified"),
          Text("Birds not identified"),
        ],
      ),
    ),
    History(),
    Notes(),
  ];

  @override
  Widget build(BuildContext context) {
    // var dir = Directory("/data/user/0/com.example.aibirdie/app_flutter/");
    // var stream = dir.list(recursive: false);
    // stream.listen((file) {
    //   print(file.path);
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Birdie"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () => Navigator.of(context).pop()),
        ],
      ),
      drawer: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("email@xyz.com"),
              accountName: Text("Jane Doe"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.account_circle, size: 70, color: Colors.green),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About AI-Birdie"),
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  style: AlertStyle(descStyle: level1, titleStyle: level2),
                  title: "AI Birdie",
                  desc:
                      "A mobile app for image and audio classification of birds.\n\nLEVERAGING THE POWER OF AI TO DEMOCRATIZE ORNITHOLOGY\n\n1.\t\tFor visual identification, our objective is to develop algorithms for:\nA.\tBird Detection in images\nB.\tBird Identification from images\n\n2.\t\tFor acoustic identification, our objective is to develop algorithms for:\nA.\tBird Detection in audio clip\nB.\tSpecies Identification in audio clip",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Tell a friend"),
              onTap: () {
                Share.share(
                    "Hey! Check out this amazing app. It is called AI Birdie.");
              },
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text("Send us feedback"),
              onTap: () async {
                final Email email = Email(
                  body: 'Write your feedback here.',
                  subject: 'Feedback for AI Birdie app',
                  recipients: ['jsonani98@gmail.com'],
                  isHTML: false,
                );

                await FlutterEmailSender.send(email);
              },
            ),
            Divider(),
            ListTile(
              enabled: true,
              leading: Icon(FontAwesomeIcons.firstAid),
              title: Text("Veterinary Services"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VServices()),
                );
              },
            ),
            Divider(),
            ListTile(
              enabled: false,
              leading: Icon(Icons.account_circle),
              title: Text("Account"),
            ),
            ListTile(
              enabled: false,
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            Expanded(
              child: Container(),
            ),
            Text("version 1.0"),
          ],
        ),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) => setState(() => _selectedPage = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text("Dashboard")),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text("History")),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add), title: Text("Save")),
        ],
      ),
    );
  }
}
