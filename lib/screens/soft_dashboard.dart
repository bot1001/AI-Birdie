import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/dash.dart';
import 'package:aibirdie/screens/my_notes.dart';
import 'package:aibirdie/screens/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';



final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class SoftDashboard extends StatefulWidget {
  @override
  _SoftDashboardState createState() => _SoftDashboardState();
}

class _SoftDashboardState extends State<SoftDashboard>
    with SingleTickerProviderStateMixin {

  TabController controller;

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

  int _selectedPage = 0;
  int currentTabIndex = 0;
  final _pages = [
    Dash(),
    MyNotes(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color(0xfff5f5f5),
      drawer: Drawer(
        child: Container(
          child: Center(child: Text("This is drawer")),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print("object");
_scaffoldKey.currentState.openDrawer();                      //  _scaffoldKey.currentState.openDrawer();
                    },
                    child: Column(
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
                          SizedBox(
                            height: 6.0,
                          ),
                          Container(
                            height: 2.00,
                            width: 22.00,
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(4.00),
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Container(
                            height: 2.00,
                            width: 11.00,
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(4.00),
                            ),
                          ),
                        ]),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
      bottomNavigationBar: Container(
        // height: 70,
        color: darkPurple,
        child: TabBar(
          indicatorColor: softGreen,
          // dragStartBehavior: DragStartBehavior.start,
          indicator: CircleTabIndicator(color: softGreen, radius: 3),
          onTap: (index){
            setState(() {
              _selectedPage = index;
            });
          },

          unselectedLabelColor: Colors.grey,
          labelColor: softGreen,
          controller: controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.dashboard),
              child: SizedBox(height: 0,),
            ),
            Tab(
              icon: Icon(Icons.note),
              child: SizedBox(height: 0,),
              // child: SizedBox(height: currentTabIndex == 1 ? 10 : 0,),
            ),
            Tab(
              icon: Icon(Icons.settings),
              child: SizedBox(height: 0,),
              // child: SizedBox(height: currentTabIndex == 2 ? 10 : 0,),
            ),
          ],
        ),
      ),

      // Container(
      //   height: 70,
      //   child: BottomNavigationBar(
      //       backgroundColor: darkPurple,
      //       onTap: (int index) => setState(() => _selectedPage = index),
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.dashboard,
      //               color: _selectedPage == 0 ? softGreen : Colors.white,
      //             ),
      //             title: Text(
      //               "•",
      //               style: _selectedPage == 0 ? level2g : level1dp,
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Icon(
      //               FontAwesomeIcons.stickyNote,
      //               color: _selectedPage == 1 ? softGreen : Colors.white,
      //             ),
      //             title: Text(
      //               "•",
      //               style: _selectedPage == 1 ? level2g : level1dp,
      //             )),
      //         BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.settings,
      //               color: _selectedPage == 2 ? softGreen : Colors.white,
      //             ),
      //             title: Text(
      //               "•",
      //               style: _selectedPage == 2 ? level2g : level1dp,
      //             )),
      //       ]
      //   ),
      // ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
