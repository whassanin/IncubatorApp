import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientDetailScreen extends StatelessWidget {
  static const routeName = '/patientdetailscreen';

  final UserPermission userPermission;
  PatientDetailScreen({this.userPermission});

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
            if (patientModel.currentPatient.userId != null) {
              currentWidget = PatientDetailRowWidget(
                patient: patientModel.currentPatient,
                userPermission: userPermission,
              );
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
