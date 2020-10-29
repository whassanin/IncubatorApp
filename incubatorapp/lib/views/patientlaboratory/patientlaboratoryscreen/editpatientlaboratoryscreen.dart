import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:incubatorapp/scopedmodels/patientlaboratorymodel.dart';
import 'package:incubatorapp/widgets/form/patientlaboratoryformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditPatientLaboratoryScreen extends StatelessWidget {
  static const routeName = '/editpatientlaboratoryscreen';

  final Laboratory laboratory;
  final PatientLaboratory patientLaboratory;
  EditPatientLaboratoryScreen({this.laboratory,this.patientLaboratory});

  @override
  Widget build(BuildContext context) {

    String title = 'Edit Laboratory to Patient';
    if(userPermission.isPatient || userPermission.isNurse){
      title = 'Results';
    }

    return ScopedModel<PatientLaboratoryModel>(
      model: patientLaboratoryModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, PatientLaboratoryModel patientLaboratoryModel){
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(title,style: TextStyle(color: Colors.white)),
            ),
            body: PatientLaboratoryFormWidget(patientLaboratory: patientLaboratory,laboratory: laboratory,)
          );
        },
      ),
    );
  }
}
