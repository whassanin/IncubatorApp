import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientanalysisrowwidget.dart';

class PatientAnalysisListWidget extends StatefulWidget {
  final List<PatientAnalysis> patientAnalysisList;
  final UserPermission userPermission;
  PatientAnalysisListWidget({this.patientAnalysisList, this.userPermission});

  @override
  _PatientAnalysisListWidgetState createState() =>
      _PatientAnalysisListWidgetState();
}

class _PatientAnalysisListWidgetState extends State<PatientAnalysisListWidget> {
  List<PatientAnalysis> addCalculatedList = [];

  double calculate() {
    double total = 0;

    if (analysisModel.analysisList != null) {
      if (widget.patientAnalysisList != null) {
        if (widget.patientAnalysisList.length > 0) {
          widget.patientAnalysisList.forEach(
            (pa) {
              int index = addCalculatedList.indexOf(pa);
              if (index < 0) {
                Analysis analysis = analysisModel.analysisList
                    .where((a) => a.id == pa.analysisId)
                    .toList()[0];
                total += analysis.price;
              }
            },
          );
        }
      }
    }
    return total;
  }

  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.patientAnalysisList != null) {
      if (widget.patientAnalysisList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.patientAnalysisList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientAnalysisRowWidget(
              patientAnalysis: widget.patientAnalysisList[i],
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
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('Loading...'),
        ),
      );
    }

    if (widget.userPermission.isPatient) {
      currentWidget = Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: currentWidget,
      );
    }

    return currentWidget;
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = getList();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: getList()));

    Widget positionTotal = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Text(
              'Total: ' + calculate().toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );

    if (widget.userPermission.isPatient) {
      calculate();
      currentWidget = Stack(
        children: <Widget>[positionList, positionTotal],
      );
    }

    return currentWidget;
  }
}
