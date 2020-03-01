import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/dash.dart';
import 'package:aibirdie/screens/my_notes.dart';
import 'package:aibirdie/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SoftDashboard extends StatefulWidget {
  @override
  _SoftDashboardState createState() => _SoftDashboardState();
}

class _SoftDashboardState extends State<SoftDashboard> {
  int _selectedPage = 0;
  final _pages = [
    Dash(),
    MyNotes(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff5f5f5),
      drawer: Drawer(
        child: Container(
          child: Center(child: Text("This is drawer")),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
                      child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 2.00,
                            width: 22.00,
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(4.00),
                            ),
                          ),
                          SizedBox(height: 6.0,),
                          Container(
                            height: 2.00,
                            width: 22.00,
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(4.00),
                            ),
                          ),                        SizedBox(height: 6.0,),

                          Container(
                            height: 2.00,
                            width: 11.00,
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(4.00),
                            ),
                          ),
                        ]),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: softGreen,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    )
                  ],
                ),
                _pages[_selectedPage],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: BottomNavigationBar(
            backgroundColor: darkPurple,
            onTap: (int index) => setState(() => _selectedPage = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard,
                    color: _selectedPage == 0 ? softGreen : Colors.white,
                  ),
                  title: Text(
                    "•",
                    style: _selectedPage == 0 ? level2g : level1dp,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.stickyNote,
                    color: _selectedPage == 1 ? softGreen : Colors.white,
                  ),
                  title: Text(
                    "•",
                    style: _selectedPage == 1 ? level2g : level1dp,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: _selectedPage == 2 ? softGreen : Colors.white,
                  ),
                  title: Text(
                    "•",
                    style: _selectedPage == 2 ? level2g : level1dp,
                  )),
            ]),
      ),
    );
  }
}
