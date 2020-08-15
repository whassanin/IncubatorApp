import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Image.asset(
                          'assets/Logo.jpg',
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Container(child: Text('Welcome to Incubator App.'),)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Container(child: Text('Please wait while loading.'),)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Container(child: CircularProgressIndicator(),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
