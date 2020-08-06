import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/widgets/row/patientanalysisrowwidget.dart';

class PatientAnalysisListWidget extends StatefulWidget {
  final List<PatientAnalysis> patientAnalysisList;
  final bool isPatient;
  PatientAnalysisListWidget({this.patientAnalysisList,this.isPatient});

  @override
  _PatientAnalysisListWidgetState createState() =>
      _PatientAnalysisListWidgetState();
}

class _PatientAnalysisListWidgetState extends State<PatientAnalysisListWidget> {
  List<PatientAnalysis> addCalculatedList = [];

  double calculate() {
    double total = 0;
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
            );
          },
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: currentWidget,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    calculate();

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

    return Stack(
      children: <Widget>[
        positionList,
        (widget.isPatient?positionTotal:Container()),
      ],
    );
  }
}
