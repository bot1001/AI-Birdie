import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/chips/Image_chip.dart';
import 'package:aibirdie/screens/chips/audio_chip.dart';
import 'package:aibirdie/screens/chips/overview_chip.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> with SingleTickerProviderStateMixin {
  TabController controller;
  int _currentIndex = 0;
  var _lines = [
    "Your activity at a glance",
    "Images you have captured",
    "Audio clips recorded"
  ];

  final _pages = [
    OverviewChip(),
    ImageChip(),
    AudioChip(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dashboard",
                style: TextStyle(fontSize: 35, fontFamily: 'OS_semi_bold'),
              ),
              Text(_lines[_currentIndex], style: level2softdp),
            ],
          ),
        ),
        Container(
          height: 40,
          child: TabBar(
            controller: controller,
            indicator: BoxDecoration(
              color: softGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            // indicator: CustomTabIndicator(),
            labelColor: Colors.white,
            labelStyle: level2softw,
            unselectedLabelColor: darkPurple,
            unselectedLabelStyle: level2softdp,
            onTap: ((index) => setState(() => _currentIndex = index)),

            tabs: <Widget>[
              Tab(
                text: "Overview",
                // child: Text("Overview"),
              ),
              Tab(
                text: "Image",
              ),
              Tab(
                text: "Audio",
              ),
            ],
          ),




        ),
        SizedBox(
          height: 30,
        ),
        _pages[_currentIndex],
      ],
    );
  }
}
