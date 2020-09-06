import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/widgets/List/analysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/newpatientanalysisscreen';

  final Patient patient;
  NewPatientAnalysisScreen({this.patient,});

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
              title: Text('Add Analysis to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: AnalysisListWidget(
              patient: patient,
              analysisList: analysisModel.analysisList,
            ),
          );
        },
      ),
    );
  }
}
