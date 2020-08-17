import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/widgets/form/usertypeformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class UserTypeScreen extends StatelessWidget {
  static const routeName = '/usertypescreen';

  @override
  Widget build(BuildContext context) {
    userModel.createUser();
    return ScopedModel(
      model: userModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context,Widget child, UserModel userModel){
          return Scaffold(
            appBar: AppBar(
              title: Text('Select User Type'),
            ),
            body: UserTypeFromWidget(),
          );
        },
      ),
    );
  }
}
