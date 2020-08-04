import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';

class PatientAnalysisRowWidget extends StatefulWidget {
  final PatientAnalysis patientAnalysis;
  PatientAnalysisRowWidget({this.patientAnalysis});
  @override
  _PatientAnalysisRowWidgetState createState() =>
      _PatientAnalysisRowWidgetState();
}

class _PatientAnalysisRowWidgetState extends State<PatientAnalysisRowWidget> {

  String dateFormat() {
    String v = widget.patientAnalysis.createdDate.day.toString();
    v = v + '/' + widget.patientAnalysis.createdDate.month.toString();
    v = v + '/' + widget.patientAnalysis.createdDate.year.toString();
    return v;
  }

  Widget patientAnalysisRow() {
    Analysis analysis = analysisModel.analysisList
        .where((element) => element.id == widget.patientAnalysis.analysisId)
        .toList()[0];

    Widget analysisNameWidget = Container(
      child: Text('Name: '+analysis.name+':'+analysis.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Result: '+widget.patientAnalysis.result),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: '+dateFormat()),
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: analysisNameWidget,
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        )
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayCol,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10,),)
      ),
      elevation: 4,
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: displayCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return patientAnalysisRow();
  }
}
