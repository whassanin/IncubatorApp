import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/screens/patientanalysisscreen/newpatientanalysisscreen.dart';
import 'package:incubatorapp/widgets/List/patientanalysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/patientanalysisscreen';

  final Patient patient;
  final UserPermission userPermission;
  PatientAnalysisScreen({this.patient, this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientAnalysisModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientAnalysisModel patientAnalysisModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Analysis',style: TextStyle(color: Colors.white),),
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
                        builder: (context) => NewPatientAnalysisScreen(
                          patient: patient,
                          userPermission: userPermission,
                        ),
                      ),
                    );
                  },
                ):Container())
              ],
            ),
            body: PatientAnalysisListWidget(
              patientAnalysisList: patientAnalysisModel.patientAnalysisList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
