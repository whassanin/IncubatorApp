import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/widgets/List/xraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class NewPatientXRayScreen extends StatelessWidget {
  static const routeName = '/newpatientxrayscreen';

  final Patient patient;
  NewPatientXRayScreen({this.patient,});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientXRayModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, PatientXRayModel patientXRayModel){
          return Scaffold(

            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Add XRay to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: XRayListWidget(patient: patient,xRayList: xRayModel.xRayList,),
          );
        },
      ),
    );
  }
}
