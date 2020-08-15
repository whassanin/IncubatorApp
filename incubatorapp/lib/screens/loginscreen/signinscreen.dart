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
                  color: Colors.blueGrey,
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      image: AssetImage('assets/Logo.jpg'),
                      fit: BoxFit.fill,
                      alignment: Alignment.center
                  ),
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
