import 'package:flutter/material.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/analysisrowwidget.dart';

class AnalysisListWidget extends StatefulWidget {
  final Patient patient;
  final List<Analysis> analysisList;
  final UserPermission userPermission;
  AnalysisListWidget({this.patient,this.analysisList, this.userPermission});

  @override
  _AnalysisListWidgetState createState() => _AnalysisListWidgetState();
}

class _AnalysisListWidgetState extends State<AnalysisListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.analysisList != null) {
      if (widget.analysisList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.analysisList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnalysisRowWidget(
              analysis: widget.analysisList[index],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Analysis(s) Available'),
          ),
        );
      }
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return _getList();
  }
}
