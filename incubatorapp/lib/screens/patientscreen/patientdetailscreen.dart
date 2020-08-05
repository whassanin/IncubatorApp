import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientDetailScreen extends StatelessWidget {
  PatientDetailScreen() {
    patientModel.readById('2');
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

          if (patientModel.currentPatient != null) {
            if (patientModel.currentPatient.id != null) {
              currentWidget = PatientDetailRowWidget(
                patient: patientModel.currentPatient,
              );
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Patient Profile'),
            ),
            body: currentWidget,
          );
        },
      ),
    );
  }
}
