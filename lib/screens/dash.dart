import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Chip(
              label: Container(
                width: 70,
                child: Center(
                  child: Text(
                    "Overview",
                    style: level2softw,
                  ),
                ),
              ),
              backgroundColor: softGreen,
            ),
            Chip(
              label: Container(
                width: 70,
                child: Center(
                  child: Text(
                    "Image",
                    style: level2softdp,
                  ),
                ),
              ),
              // backgroundColor: Colors.white
            ),
            Chip(
              label: Container(
                width: 70,
                child: Center(
                  child: Text(
                    "Audio",
                    style: level2softdp,
                  ),
                ),
              ),
              // backgroundColor: Colors.white
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 150.00,
          // width: 315.00,
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
          child: null
        ),
        SizedBox(height: 30),
        Container(
          height: 150.00,
          // width: 315.00,
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
        ),
      ],
    );
  }
}
