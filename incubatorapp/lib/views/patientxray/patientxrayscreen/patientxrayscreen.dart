import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/views/patientxray/patientxrayscreen/newpatientxrayscreen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => NewPatientXRayScreen(),
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
