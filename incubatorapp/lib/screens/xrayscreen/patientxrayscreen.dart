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
  PatientXRayScreen({this.patient,this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientXRayModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientXRayModel patientXRayModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('XRay',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isDoctor == true?IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
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
