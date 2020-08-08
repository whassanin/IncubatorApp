import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/widgets/List/patientmedicinedoctorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientMedicineDoctorDetailScreen extends StatelessWidget {
  static const routeName = '/patientmedicinedoctordetailscreen';

  final Patient patient;
  final UserPermission userPermission;
  NewPatientMedicineDoctorDetailScreen({this.patient, this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Confirm'),
            ),
            body: PatientMedicineDoctorListWidget(
              isConfirm: true,
              patientMedicineDoctorList:
              patientMedicineDoctorModel.confirmPatientMedicineDoctorList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
