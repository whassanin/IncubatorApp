import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/widgets/form/patientxrayformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPatientXRayScreen extends StatelessWidget {
  static const routeName = '/editpatientlaboratoryscreen';

  final XRay xRay;
  final PatientXRay patientXRay;
  EditPatientXRayScreen({this.xRay, this.patientXRay});

  @override
  Widget build(BuildContext context) {

    String title = 'Edit XRay to Patient';
    if(userPermission.isPatient || userPermission.isNurse){
      title = 'Results';
    }

    return ScopedModel<PatientXRayModel>(
      model: patientXRayModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientXRayModel patientXRayModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(title,style: TextStyle(color: Colors.white)),
            ),
            body: PatientXRayFormWidget(
              patientXRay: patientXRay,
              xRay: xRay,
            ),
          );
        },
      ),
    );
  }
}
