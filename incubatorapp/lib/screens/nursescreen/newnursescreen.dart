import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/widgets/form/nurseformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewNurseScreen extends StatelessWidget {
  static const routeName = '/newnursescreen';

  @override
  Widget build(BuildContext context) {
    userModel.createUser();
    userModel.setUserType('Nurse');
    nurseModel.createNurse();
    return ScopedModel(
      model: nurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            NurseModel nurseModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Register Nurse'),
            ),
            body: NurseFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
