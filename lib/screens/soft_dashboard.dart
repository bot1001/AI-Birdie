import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/dash.dart';
import 'package:aibirdie/screens/my_notes.dart';
import 'package:aibirdie/screens/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/screens/landing_page.dart';

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
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0.0,
        leading: _menuButton(),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10, top: 15),
            child: FloatingActionButton(
              elevation: 0.0,
              onPressed: (() => LandingPage.controller.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut)),
              backgroundColor: softGreen,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          )
        ],
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              // arrowColor: myGreen,
              accountEmail: Text("email@xyz.com"),
              accountName: Text("Jane Doe"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.account_circle, size: 70, color: Colors.green),
              ),
            ),


          ],
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: _pages[_selectedPage],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(
                  0.0, // horizontal, move right 10
                  -10.0, // vertical, move down 10
                ),
              ),
            ],
            // color: darkPurple,
          ),

/*

TabBar(
          indicatorColor: softGreen,
          // indicator: CircleTabIndicator(color: softGreen, radius: 3),
          onTap: (index) {
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
              text: "Dashboard",
            ),
            Tab(
              icon: Icon(Icons.note),
              text: "Notes",
              // child: SizedBox(height: currentTabIndex == 1 ? 10 : 0,),
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: "Settings",
              // child: SizedBox(height: currentTabIndex == 2 ? 10 : 0,),
            ),
          ],
        ),





*/

          child: BottomNavigationBar(
            backgroundColor: darkPurple,
            selectedItemColor: softGreen,
            selectedLabelStyle: level2softg.copyWith(fontSize: 12),
            // selectedIconTheme: IconThemeData(size: 25),
            currentIndex: _selectedPage,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey,

            onTap: (index) {
              setState(() {
                _selectedPage = index;
              });
            },

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text("Dashboard"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                title: Text("Notes"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ],
          )),
    );
  }

  Widget _menuButton() {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: RawMaterialButton(
        onPressed: (() => _scaffoldKey.currentState.openDrawer()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 6.0),
                height: 2.00,
                width: 22.00,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 6.0),
                height: 2.00,
                width: 16.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                height: 2.00,
                width: 11.00,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
            ]),
      ),
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
