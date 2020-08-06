import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/screens/analysisscreen/newpatientanalysisscreen.dart';
import 'package:incubatorapp/widgets/List/patientanalysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/patientanalysisscreen';

  final int patientId;
  final bool isPatient;
  PatientAnalysisScreen({this.patientId, this.isPatient}) {
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
            ),
            floatingActionButton: (isPatient == false
                ? FloatingActionButton(
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPatientAnalysisScreen()),
                        );
                      },
                    ),
                  )
                : Container()),
            body: PatientAnalysisListWidget(
              patientAnalysisList: patientAnalysisModel.patientAnalysisList,
              isPatient: isPatient,
            ),
          );
        },
      ),
    );
  }
}
