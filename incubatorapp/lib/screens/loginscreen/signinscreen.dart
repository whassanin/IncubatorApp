import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/form/signinformwidget.dart';

class SignInScreen extends StatelessWidget {

  static const routeName = '/signinscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Hero(tag: 'SignIn',child: SignInFormWidget())
    );
  }
}
