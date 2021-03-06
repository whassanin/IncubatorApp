import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientDetailScreen extends StatelessWidget {
  static const routeName = '/patientdetailscreen';

  PatientDetailScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientModel>(
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
            if (patientModel.currentPatient.userId != null) {
              if(patientModel.isLoading!=null){
                if (patientModel.isLoading == false) {
                  currentWidget = PatientDetailRowWidget(
                    patient: patientModel.currentPatient,
                  );
                }
              }
            }
          }

          return Scaffold(
            appBar: ((userPermission.isDoctor || userPermission.isNurse)
                ? AppBar(
                    title: Text('Patient Profile',
                        style: TextStyle(color: Colors.white)),
                    leading: BackButton(
                      color: Colors.white,
                    ),
                  )
                : null),
            body: currentWidget,
          );
        },
      ),
    );
  }
}
