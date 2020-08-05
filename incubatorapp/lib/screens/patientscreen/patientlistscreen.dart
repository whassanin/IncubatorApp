import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/List/patientlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientListScreen extends StatelessWidget {
  static const routeName = '/patientListscreen';

  PatientListScreen(){
    patientModel.filterByStatus('in');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, PatientModel patientModel) {
          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if (patientModel.patientList != null) {
            currentWidget = PatientListWidget(
              patientList: patientModel.patientList,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Patient List'),
            ),
            body: currentWidget,
          );
        },
      ),
    );
  }
}
