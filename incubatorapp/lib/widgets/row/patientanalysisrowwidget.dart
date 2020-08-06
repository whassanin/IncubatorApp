import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/analysisscreen/editpatientanalysisscreen.dart';

class PatientAnalysisRowWidget extends StatefulWidget {
  final PatientAnalysis patientAnalysis;
  final UserPermission userPermission;
  PatientAnalysisRowWidget({this.patientAnalysis, this.userPermission});
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
      child: Text('Name: ' + analysis.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + analysis.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Result: ' + widget.patientAnalysis.result),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: ' + dateFormat()),
    );

    Widget editButtonWidget = Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Edit'),
            onPressed: () {
              patientAnalysisModel.editPatientAnalysis(widget.patientAnalysis);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPatientAnalysisScreen(
                    patientAnalysis: widget.patientAnalysis,
                    analysis: analysis,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: analysisNameWidget,
        ),
        SizedBox(
          height: 5,
        ),
        (widget.userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: priceWidget,
              )
            : Container()),
        (widget.userPermission.isPatient
            ? SizedBox(
                height: 5,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        ),
        (widget.userPermission.isDoctor ? editButtonWidget : Container)
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayCol,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
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
