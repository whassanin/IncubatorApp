import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/screens/xrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/widgets/List/patientxraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientXRayScreen extends StatelessWidget {
  static const routeName = '/patientxrayscreen';

  final Patient patient;
  final UserPermission userPermission;
  PatientXRayScreen({this.patient,this.userPermission}){
    patientXRayModel.createPatientXRay();
    patientXRayModel.setPatientId(patient.id);
    patientXRayModel.readByPatientId();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientXRayModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientXRayModel patientXRayModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('XRay'),
              actions: <Widget>[
                (userPermission.isDoctor == true?IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPatientXRayScreen(
                          patient: patient,
                          userPermission: userPermission,
                        ),
                      ),
                    );
                  },
                ):Container())
              ],
            ),
            body: PatientXRayListWidget(
              patientXRayList: patientXRayModel.patientXRayList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
