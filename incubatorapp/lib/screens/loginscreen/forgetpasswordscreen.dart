import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/widgets/form/forgetpasswordformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = '/forgetpasswordscreen';

  @override
  Widget build(BuildContext context) {
    userModel.createUser();
    return ScopedModel<UserModel>(
      model: userModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, UserModel userModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Forget Password Screen',
                  style: TextStyle(color: Colors.white)),
            ),
            backgroundColor: Colors.white,
            body: Hero(
              tag: 'forgetPassword',
              child: ForgetPasswordFormWidget(),
            ),
          );
        },
      ),
    );
  }
}
