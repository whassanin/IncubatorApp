import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';

class AnalysisRowWidget extends StatefulWidget {
  final Patient patient;
  final Analysis analysis;
  final UserPermission userPermission;
  AnalysisRowWidget({this.patient, this.analysis, this.userPermission});
  @override
  _AnalysisRowWidgetState createState() => _AnalysisRowWidgetState();
}

class _AnalysisRowWidgetState extends State<AnalysisRowWidget> {
  bool isSelected = false;

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void validate() {
    String dn = dateFormat(DateTime.now());

    int i = patientAnalysisModel.patientAnalysisList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.analysisId == widget.analysis.id &&
            dateFormat(element.createdDate) == dn);
    if (i >= 0) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  void save() {
    patientAnalysisModel.createPatientAnalysis();
    patientAnalysisModel.setPatientId(widget.patient.id);
    patientAnalysisModel.setAnalysisId(widget.analysis.id);
    patientAnalysisModel.create();
  }

  void delete() {
    String dn = dateFormat(DateTime.now());

    patientAnalysisModel.createPatientAnalysis();
    patientAnalysisModel.setPatientId(widget.patient.id);
    patientAnalysisModel.setAnalysisId(widget.analysis.id);

    int i = patientAnalysisModel.patientAnalysisList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.analysisId == widget.analysis.id &&
            dateFormat(element.createdDate) == dn);

    if(i >= 0){
      isSelected = true;
      patientAnalysisModel.editPatientAnalysis(patientAnalysisModel.patientAnalysisList[i]);
      patientAnalysisModel.delete();
    }

  }

  Widget row() {
    validate();

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.analysis.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.analysis.name,
            ),
          ),
        ),
        (widget.userPermission.isDoctor
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  if (b == true) {
                    save();
                  } else {
                    delete();
                  }
                },
              )
            : Container())
      ],
    );

    Widget rowContainer = Container(
      height: 50,
      child: Padding(padding: const EdgeInsets.only(left: 10), child: rowData),
    );

    Widget rowCard = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: rowContainer,
    );

    return GestureDetector(
      onTap: () {
        if (widget.userPermission.isFrontDesk) {
        } else {}
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        child: rowCard,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
