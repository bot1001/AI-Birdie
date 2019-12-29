// import 'dart:io';

import 'package:aibirdie/screens/notes.dart';
import 'package:flutter/material.dart';

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
    Center(child: Text("Data 2")),
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
                    Icon(Icons.account_circle, size: 60, color: Colors.green),
              ),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Help"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About AI-Birdie"),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Tell a friend"),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text("Send us feedback"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Account"),
            ),
            ListTile(
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
              icon: Icon(Icons.history), title: Text("Something")),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add), title: Text("Save")),
        ],
      ),
    );
  }
}
