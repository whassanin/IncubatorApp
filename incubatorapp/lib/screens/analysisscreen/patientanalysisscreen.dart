import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/screens/analysisscreen/newpatientanalysisscreen.dart';
import 'package:incubatorapp/widgets/List/patientanalysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/patientanalysisscreen';

  final int patientId;
  final UserPermission userPermission;
  PatientAnalysisScreen({this.patientId, this.userPermission}) {
    patientAnalysisModel.createPatientAnalysis();
    patientAnalysisModel.setPatientId(patientId);
    patientAnalysisModel.readByPatientId();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientAnalysisModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientAnalysisModel patientAnalysisModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Analysis'),
              actions: <Widget>[
                (userPermission.isDoctor == true?IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPatientAnalysisScreen(
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
