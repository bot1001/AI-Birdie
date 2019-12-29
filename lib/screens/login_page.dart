import 'package:aibirdie/constants.dart';
import 'package:flutter/material.dart';
import 'package:aibirdie/components/buttons.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: 200,
                ),
                Text(
                  "AI Birdie",
                  style: heading1,
                ),
                Column(
                  children: <Widget>[
                    solidButton("L O G I N", () {}),
                    SizedBox(
                      height: 20,
                    ),
                    lightButton("R E G I S T E R", () {}),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'camera_screen');
                  },
                  
                  child: Text("Skip")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
