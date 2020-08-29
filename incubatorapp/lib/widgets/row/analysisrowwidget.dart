import 'package:flutter/material.dart';
import 'package:huawei_push/push.dart';
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

  void update() {
    int index = findAnalysis();
    if (index >= 0) {
      delete(index);
    } else if (index < 0) {
      save();
    }
  }

  int findAnalysis() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    patientAnalysisModel.patientAnalysisList.forEach((element) {
      if(element.patientId == widget.patient.userId &&
          element.analysisId == widget.analysis.id &&
      dateFormat(element.createdDate) == dn){
        index = patientAnalysisModel.patientAnalysisList.indexOf(element);
      }
    });

   return index;
  }

  void delete(int index) {
    patientAnalysisModel.editPatientAnalysis(patientAnalysisModel.patientAnalysisList[index]);
    patientAnalysisModel.delete();
  }

  void save() async {
    patientAnalysisModel.createPatientAnalysis();
    patientAnalysisModel.setPatientId(widget.patient.userId);
    patientAnalysisModel.setAnalysisId(widget.analysis.id);
    patientAnalysisModel.create();
  }

  Widget row() {
    int index = findAnalysis();

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if(index >= 0){
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.analysis.id.toString(),style: TextStyle(color: textColor)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.analysis.name,
                style: TextStyle(color: textColor)
            ),
          ),
        ),
      ],
    );

    Widget rowContainer = Container(
      height: 70,
      child: Padding(padding: const EdgeInsets.only(left: 10), child: rowData),
    );

    Widget rowCard = Card(
      color: cardColor,
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
        if (widget.userPermission.isDoctor) {
          update();
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
