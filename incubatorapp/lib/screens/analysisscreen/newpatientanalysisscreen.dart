import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/widgets/List/analysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class NewPatientAnalysisScreen extends StatelessWidget {
  static const routeName = '/newpatientanalysisscreen';

  final UserPermission userPermission;
  NewPatientAnalysisScreen({this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientAnalysisModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, PatientAnalysisModel patientAnalysisModel){
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Analysis to Patient'),
            ),
            body: AnalysisListWidget(analysisList: analysisModel.analysisList,userPermission: userPermission,),
          );
        },
      ),
    );
  }
}
