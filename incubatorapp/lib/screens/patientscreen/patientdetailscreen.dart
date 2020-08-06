import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientDetailScreen extends StatelessWidget {
  static const routeName = '/patientdetailscreen';

  final bool isPatient;
  PatientDetailScreen({this.isPatient});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, PatientModel patientModel) {
          Widget currentWidget = Container();

          if (patientModel.currentPatient != null) {
            if (patientModel.currentPatient.id != null) {
              if (isPatient) {
                currentWidget = PatientDetailRowWidget(
                  patient: patientModel.currentPatient,
                  isPatient: isPatient,
                );
              } else {
                currentWidget = Scaffold(
                  appBar: AppBar(
                    title: Text('Patient Profile'),
                  ),
                  body: PatientDetailRowWidget(
                    patient: patientModel.currentPatient,
                    isPatient: isPatient,
                  ),
                );
              }
            }
          }

          return currentWidget;
        },
      ),
    );
  }
}
