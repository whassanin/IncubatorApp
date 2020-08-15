import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: AssetImage('assets/BackgroundImage.jpg'),
                      fit: BoxFit.fill,
                      alignment: Alignment.center),
                ),
                child: Center(
                  child: Text('Welcome'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
