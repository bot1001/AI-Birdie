import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  TabController controller;
  bool signedIn = false;
  GoogleSignIn googleSignIn = GoogleSignIn(signInOption: SignInOption.standard);
  SharedPreferences prefs;
  String userEmail;
  String userAccountName;
  String userPhotoURL = "https://image.flaticon.com/icons/svg/2922/2922523.svg";
  bool showSpinner = false;

  int _selectedPage = 0;
  int currentTabIndex = 0;
  final _pages = [
    Dash(),
    MyNotes(),
    CheckList(),
  ];

  var appBarTitle = [
    "Dashboard",
    "My Notes",
    "Checklist",
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    getSignInStatus();
  }

  void getSignInStatus() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      signedIn = prefs.getBool('SignInStatus');
    });
    setState(() {
      userEmail = prefs.getString('userEmail');
      userAccountName = prefs.getString('userAccountName');
      userPhotoURL = prefs.getString('userPhotoURL');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xfffafafa),
      //   elevation: 0.0,
      //   leading: _menuButton(),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: darkPurple,
        onPressed: (() => LandingPage.controller.animateToPage(1,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut)),
      ),
      key: _scaffoldKey,
      drawer: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Drawer(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                signedIn ? signedInWidget() : notSignedInWidget(),
                signedIn ? Container() : signInWithGoogleButton(),
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
                Spacer(),
                signedIn
                    ? FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: signOut,
                        child: Text(
                          "Sign out",
                          style: level2softw,
                        ),
                        color: softGreen,
                      )
                    : Container(),
              ],
            ),
          ),
        )),
      ),

      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: darkPurple,
            leading: _menuButton(),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            forceElevated: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,

              title: Text(
                appBarTitle[_selectedPage],
                style: level2softdp.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              background:
              //  Image.asset('images/2.jpg', fit: BoxFit.cover,)
              
              Container(
                color: softGreen,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: _pages[_selectedPage],
            ),
          ),
        ],
      ),

      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: EdgeInsets.all(15.0),
      //       child: _pages[_selectedPage],
      //     ),
      //   ),
      // ),

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

  Widget signedInWidget() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(),
      // arrowColor: softGreen,
      onDetailsPressed: () {
        print('hi');
      },
      accountEmail: Text(
        "$userEmail",
        style: level2softdp,
      ),
      accountName: Text(
        "$userAccountName",
        style: level2softdp.copyWith(fontWeight: FontWeight.bold),
      ),

      currentAccountPicture: Material(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: ClipOval(
              child: signedIn
                  ? Image.network(
                      userPhotoURL,
                    )
                  : Container())),
    );
  }

  Widget notSignedInWidget() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(),
      accountEmail: Text(
        "Use your google account to sign in.",
        style: level2softdp,
      ),
      accountName: Text(
        "Sign In",
        style: level1dp,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.account_circle, size: 60, color: softGreen),
      ),
    );
  }

  Widget signInWithGoogleButton() {
    return Container(
      width: 220,
      child: RaisedButton(
        elevation: 5.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'images/google_logo.png',
              width: 25,
            ),
            // SizedBox(width: 10,),
            Text(
              "Sign In with Google",
              style: level2softdp,
            ),
          ],
        ),
        onPressed: signIn,
      ),
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
                width: 15.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 6.0),
                height: 2.00,
                width: 22.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
              Container(
                height: 2.00,
                // width: 11.00,
                width: 15.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.00),
                ),
              ),
            ]),
      ),
    );
  }

  void signIn() async {
    setState(() {
      showSpinner = true;
    });
    try {
      await googleSignIn.signIn();

      if (await googleSignIn.isSignedIn()) {
        SharedPreferences.getInstance()
            .then((prefs) => prefs.setBool('SignInStatus', true));
        signedIn = true;
        prefs.setString('userEmail', googleSignIn.currentUser.email);
        prefs.setString(
            'userAccountName', googleSignIn.currentUser.displayName);
        prefs.setString('userPhotoURL', googleSignIn.currentUser.photoUrl);

        setState(() {
          userEmail = googleSignIn.currentUser.email;
          userAccountName = googleSignIn.currentUser.displayName;
          userPhotoURL = googleSignIn.currentUser.photoUrl;
          showSpinner = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            action: SnackBarAction(label: 'OK', onPressed: () {}),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: darkPurple,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Signed in successfully.',
              style: level2softw,
            )));
      }
    } catch (err) {
      print('ERROR: $err');
    }
  }

  void signOut() async {
    setState(() {
      showSpinner = true;
    });

    try {
      await googleSignIn.signOut();

      if (!await googleSignIn.isSignedIn()) {
        setState(() {
          showSpinner = false;
        });
        SharedPreferences.getInstance()
            .then((prefs) => prefs.setBool('SignInStatus', false));
        setState(() => signedIn = false);
        Scaffold.of(context).showSnackBar(SnackBar(
            action: SnackBarAction(label: 'OK', onPressed: () {}),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: darkPurple,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Signed out.',
              style: level2softw,
            )));
      }
    } catch (err) {
      print('ERROR: $err');
    }
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
