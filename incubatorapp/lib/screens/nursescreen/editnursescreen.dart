import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/widgets/form/nurseformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditNurseScreen extends StatelessWidget {
  static const routeName = '/editnursescreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: nurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            NurseModel nurseModel) {
          return NurseFormWidget(
            isEdit: true,
          );
        },
      ),
    );
  }
}
