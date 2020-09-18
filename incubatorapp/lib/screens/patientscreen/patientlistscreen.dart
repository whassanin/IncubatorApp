import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/List/patientlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientListScreen extends StatelessWidget {
  static const routeName = '/patientListscreen';

  PatientListScreen();

  @override
  Widget build(BuildContext context) {
    patientModel.filterByStateType(1);

    return ScopedModel<PatientModel>(
      model: patientModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, PatientModel patientModel) {
          return PatientListWidget(
            patientList: patientModel.patientList,
          );
        },
      ),
    );
  }
}
