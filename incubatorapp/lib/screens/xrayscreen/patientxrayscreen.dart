import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/screens/xrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/widgets/List/patientxraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientXRayScreen extends StatelessWidget {
  static const routeName = '/patientxrayscreen';

  final int patientId;
  final UserPermission userPermission;
  PatientXRayScreen({this.patientId,this.userPermission}){
    patientXRayModel.createPatientXRay();
    patientXRayModel.setPatientId(patientId);
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
