import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/widgets/form/signinformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signinscreen';

  @override
  Widget build(BuildContext context) {
    userModel.createUser();
    return ScopedModel<UserModel>(
      model: userModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, UserModel userModel) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Hero(
              tag: 'SignIn',
              child: SignInFormWidget(),
            ),
          );
        },
      ),
    );
  }
}
