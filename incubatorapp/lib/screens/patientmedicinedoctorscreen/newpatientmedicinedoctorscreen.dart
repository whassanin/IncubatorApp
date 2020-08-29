import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/widgets/List/medicinelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientMedicineDoctorScreen extends StatelessWidget {
  static const routeName = '/newpatientmedicinedoctorscreen';

  final Patient patient;
  final UserPermission userPermission;
  NewPatientMedicineDoctorScreen({this.patient, this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Add Medicine to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: MedicineListWidget(
              patient: patient,
              medicineList: medicineModel.medicineList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
