import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/constants.dart';
import 'package:aibirdie/screens/landing_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:aibirdie/screens/Dashboard/dash.dart';
import 'package:aibirdie/screens/Dashboard/my_notes.dart';
import 'package:aibirdie/screens/Dashboard/checklist.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aibirdie/screens/Dashboard/drawer/v_services.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
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
    CheckList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0.0,
        leading: _menuButton(),
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.only(right: 10, top: 15),
        //     child: FloatingActionButton(
        //       elevation: 0.0,
        //       onPressed: (() => LandingPage.controller.animateToPage(1,
        //           duration: Duration(milliseconds: 300),
        //           curve: Curves.easeInOut)),
        //       backgroundColor: softGreen,
        //       child: Icon(
        //         Icons.arrow_forward_ios,
        //         size: 15,
        //       ),
        //     ),
        //   )
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: darkPurple,
        onPressed: (() => LandingPage.controller.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut)),),
      key: _scaffoldKey,
      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(),
              accountEmail: Text(
                "email@xyz.com",
                style: level2softdp,
              ),
              accountName: Text(
                "Jane Doe",
                style: level1dp,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle, size: 70, color: darkPurple),
              ),
            ),

            // Row(

            //   children: <Widget>[
            //     SizedBox(width: 15,),
            //     Text("OTHER", style: level1dp.copyWith(fontWeight: FontWeight.bold),),
            //   ],
            // ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: darkPurple,
              ),
              title: Text(
                "About AI-Birdie",
                style: level2softdp,
              ),
              onTap: (() => Alert(
                    context: context,
                    type: AlertType.info,
                    style: AlertStyle(
                        animationDuration: Duration(milliseconds: 500),
                        animationType: AnimationType.grow,
                        descStyle: level2softdp,
                        titleStyle: level1dp.copyWith(fontSize: 25)),
                    title: "AI Birdie",
                    desc:
                        "A mobile app for image and audio classification of birds.\n\nLEVERAGING THE POWER OF AI TO DEMOCRATIZE ORNITHOLOGY\n\n1.\t\tFor visual identification, our objective is to develop algorithms for:\nA.\tBird Detection in images\nB.\tBird Identification from images\n\n2.\t\tFor acoustic identification, our objective is to develop algorithms for:\nA.\tBird Detection in audio clip\nB.\tSpecies Identification in audio clip",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: level1w,
                        ),
                        color: softGreen,
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show()),
            ),
            ListTile(
              leading: Icon(
                // Icons.share,
                FontAwesomeIcons.shareSquare,
                color: darkPurple,
              ),
              title: Text(
                "Tell a friend",
                style: level2softdp,
              ),
              onTap: (() => Share.share(
                  "Hey! Check out this amazing app. It is called AI Birdie.")),
            ),
            ListTile(
              leading: Icon(
                Icons.mail_outline,
                color: darkPurple,
              ),
              title: Text(
                "Send us feedback",
                style: level2softdp,
              ),
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
            ListTile(
              // enabled: true,
              leading: Icon(
                Icons.healing,
                color: darkPurple,
              ),
              title: Text(
                "Veterinary Services",
                style: level2softdp,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VServices()),
                );
              },
            ),
            ListTile(
              // enabled: false,

              leading: Icon(
                Icons.settings,
                color: darkPurple,
              ),
              title: Text(
                "Settings",
                style: level2softdp,
              ),
            ),
          ],
        ),
      )),
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
                icon: Icon(Icons.playlist_add_check),
                title: Text("Checklist"),
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
                width: 22.0,
                decoration: BoxDecoration(
                  color: darkPurple,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 6.0),
                height: 2.00,
                width: 15.0,
                decoration: BoxDecoration(
                  color: darkPurple,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                height: 2.00,
                // width: 11.00,
                width: 22.0,
                decoration: BoxDecoration(
                  color: darkPurple,
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
