import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/widgets/form/patientanalysisformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditPatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/editpatientanalysisscreen';

  final Analysis analysis;
  final PatientAnalysis patientAnalysis;
  EditPatientAnalysisScreen({this.analysis,this.patientAnalysis});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientAnalysisModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, PatientAnalysisModel patientAnalysisModel){
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Analysis to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: PatientAnalysisFormWidget(patientAnalysis: patientAnalysis,analysis: analysis,)
          );
        },
      ),
    );
  }
}
