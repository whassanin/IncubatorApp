import 'package:flutter/material.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/widgets/row/patientanalysisrowwidget.dart';

class PatientAnalysisListWidget extends StatefulWidget {
  final List<PatientAnalysis> patientAnalysisList;
  PatientAnalysisListWidget({this.patientAnalysisList});

  @override
  _PatientAnalysisListWidgetState createState() =>
      _PatientAnalysisListWidgetState();
}

class _PatientAnalysisListWidgetState extends State<PatientAnalysisListWidget> {
  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if(widget.patientAnalysisList!=null){
      if(widget.patientAnalysisList.length > 0){
        currentWidget = ListView.builder(
          itemCount: widget.patientAnalysisList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientAnalysisRowWidget(
              patientAnalysis: widget.patientAnalysisList[i],
            );
          },
        );
      }
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }
}
