import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget logoImage = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10,),
        child: Container(
          child: Image.asset(
            'assets/Logo.jpg',
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
      ),
    );

    Widget welcomeTitle = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          child: Text('Welcome to Incubator App.',),
        ),
      ),
    );

    Widget waitMessage = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          child: Text('Please wait...'),
        ),
      ),
    );

    Widget progressIndBar = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      ),
    );

    Widget contentData = Column(
      children: <Widget>[
        logoImage,
        welcomeTitle,
        waitMessage,
        progressIndBar
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 23,
          bottom: 50
        ),
        child: Container(
          child: contentData
        ),
      ),
    );
  }
}
