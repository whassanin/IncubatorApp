import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/widgets/form/patientmedicinedoctorformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPatientMedicineDoctorScreen extends StatelessWidget {
  static const routeName = '/editpatientmedicinedoctorscreen';

  final Medicine medicine;
  final PatientMedicineDoctor patientMedicineDoctor;
  EditPatientMedicineDoctorScreen({this.patientMedicineDoctor, this.medicine});

  @override
  Widget build(BuildContext context) {

    String title = 'Edit Medicine to Patient';
    if(userPermission.isPatient || userPermission.isNurse){
      title = 'Results';
    }

    return ScopedModel<PatientMedicineDoctorModel>(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(title,style: TextStyle(color: Colors.white)),
            ),
            body: PatientMedicineDoctorFormWidget(
              patientMedicineDoctor: patientMedicineDoctor,
              medicine: medicine,
            ),
          );
        },
      ),
    );
  }
}
