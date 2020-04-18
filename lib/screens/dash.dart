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
              Text("Your activity at a glance", style: level2softdp),
            ],
          ),
        ),

        Container(
          height: 40,
          child: TabBar(
            controller: controller,
            indicator: CustomTabIndicator(),
            labelColor: Colors.white,
            labelStyle: level2softw.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelColor: darkPurple,
            unselectedLabelStyle: level2softdp,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: <Widget>[
              Tab(
                text: "Overview",
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
        SizedBox(height: 30,),

        _pages[_currentIndex],

        // TabBarView(
        //   controller: controller,
        //   children: <Widget>[
        //     Center(child: Text("Overview")),
        //     Center(child: Text("Overview")),
        //     Center(child: Text("Overview")),
        //   ],
        // ),

        /* Old row */
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Chip(
        //       label: Container(
        //         width: 70,
        //         child: Center(
        //           child: Text(
        //             "Overview",
        //             style: level2softw,
        //           ),
        //         ),
        //       ),
        //       backgroundColor: softGreen,
        //     ),
        //     Chip(
        //       label: Container(
        //         width: 70,
        //         child: Center(
        //           child: Text(
        //             "Image",
        //             style: level2softdp,
        //           ),
        //         ),
        //       ),
        //       // backgroundColor: Colors.white
        //     ),
        //     Chip(
        //       label: Container(
        //         width: 70,
        //         child: Center(
        //           child: Text(
        //             "Audio",
        //             style: level2softdp,
        //           ),
        //         ),
        //       ),
        //       // backgroundColor: Colors.white
        //     ),
        //   ],
        // ),

        /* Soft containers */
        // SizedBox(
        //   height: 30,
        // ),
      ],
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = softGreen;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(30.0)), paint);
  }
}
