import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage('assets/Logo.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Text('Welcome'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
