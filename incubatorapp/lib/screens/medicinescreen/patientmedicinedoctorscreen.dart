import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/screens/user/userpermission.dart';
import 'package:incubatorapp/widgets/List/patientmedicinedoctorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class PatientMedicineDoctorScreen extends StatelessWidget {
  static const routeName = '/patientmedicinedoctorscreen';

  final int patientId;
  final UserPermission userPermission;
  PatientMedicineDoctorScreen({this.patientId,this.userPermission}){
    patientMedicineDoctorModel.createPatientMedicineDoctor();
    patientMedicineDoctorModel.setPatientId(patientId);
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
            ),
            floatingActionButton: (userPermission.isDoctor == true
                ? FloatingActionButton(
              child: IconButton(
                icon: Icon(Icons.add,color: Colors.white,),
                color: Colors.blueAccent,
                onPressed: () {},
              ),
            )
                : Container()),
            body: PatientMedicineDoctorListWidget(
               patientMedicineDoctorList: patientMedicineDoctorModel.patientMedicineDoctorList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
