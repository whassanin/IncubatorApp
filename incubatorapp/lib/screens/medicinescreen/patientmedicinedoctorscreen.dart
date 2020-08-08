import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/screens/medicinescreen/newpatientmedicinedoctorscreen.dart';
import 'package:incubatorapp/widgets/List/patientmedicinedoctorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientMedicineDoctorScreen extends StatelessWidget {
  static const routeName = '/patientmedicinedoctorscreen';

  final Patient patient;
  final UserPermission userPermission;
  PatientMedicineDoctorScreen({this.patient, this.userPermission}) {
    patientMedicineDoctorModel.createPatientMedicineDoctor();
    patientMedicineDoctorModel.setPatientId(patient.id);
    patientMedicineDoctorModel.readByPatientId();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Medicine'),
              actions: <Widget>[
                (userPermission.isDoctor == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewPatientMedicineDoctorScreen(
                                patient: patient,
                                userPermission: userPermission,
                              ),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientMedicineDoctorListWidget(
              patientMedicineDoctorList:
                  patientMedicineDoctorModel.patientMedicineDoctorList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
