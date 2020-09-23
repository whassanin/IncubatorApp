import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/screens/patientxrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/widgets/List/patientxraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientXRayScreen extends StatefulWidget {
  static const routeName = '/patientxrayscreen';

  final Patient patient;
  PatientXRayScreen({this.patient});

  @override
  _PatientXRayScreenState createState() => _PatientXRayScreenState();
}

class _PatientXRayScreenState extends State<PatientXRayScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patientXRayModel.clearList();
  }

  @override
  Widget build(BuildContext context) {
    int l = patientModel.currentPatient.patientXRaysList.length;
    if (l == 0) {
      patientXRayModel.readByPatientId(patientModel.currentPatient.userId);
    } else {
      patientXRayModel.setList(patientModel.currentPatient.patientXRaysList);
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
              title: Text('XRay', style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isDoctor == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          patientXRayModel.setIsLoading(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPatientXRayScreen(
                              ),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientXRayListWidget(
              patientXRayList: patientXRayModel.patientXRayList,
            ),
          );
        },
      ),
    );
  }
}
