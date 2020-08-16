import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incubatorapp/screens/loginscreen/signinscreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget titleMessage(String title, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize, color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToSignInScreen() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SignInScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end);
              var curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToSignInScreen();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeMessage =
        titleMessage('Welcome to Incubator App.', 25, Colors.black);

    Widget logoImage = Container(
      child: Image.asset(
        'assets/Logo.png',
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 23,
          right: 10,
          left: 10,
        ),
        child: Column(
          children: <Widget>[
            welcomeMessage,
            Expanded(
              child: logoImage,
            ),
          ],
        ),
      ),
    );
  }
}
