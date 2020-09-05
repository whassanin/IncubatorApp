import 'package:flutter/material.dart';
import 'package:huawei_push/push.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/analysisscreen/editanalysisscreen.dart';

class AnalysisRowWidget extends StatefulWidget {
  final Patient patient;
  final Analysis analysis;
  AnalysisRowWidget({
    this.patient,
    this.analysis,
  });
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

  void navigateToEditAnalysisScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAnalysisScreen()));
  }

  int findAnalysis() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    patientAnalysisModel.patientAnalysisList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.analysisId == widget.analysis.id &&
          dateFormat(element.createdDate) == dn) {
        index = patientAnalysisModel.patientAnalysisList.indexOf(element);
      }
    });

    return index;
  }

  void delete(int index) {
    patientAnalysisModel
        .editPatientAnalysis(patientAnalysisModel.patientAnalysisList[index]);
    patientAnalysisModel.delete();
  }

  void save() async {
    patientAnalysisModel.createPatientAnalysis();
    patientAnalysisModel.setPatientId(widget.patient.userId);
    patientAnalysisModel.setAnalysisId(widget.analysis.id);
    patientAnalysisModel.create();
  }

  Widget row() {
    int index = -1;
    if (widget.patient != null) {
      index = findAnalysis();
    }

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if (index >= 0) {
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(widget.analysis.name,
                style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text('Price: ' + widget.analysis.price.toString(),
                style: TextStyle(color: textColor)),
          ),
        ):Container()),
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
        if (userPermission.isDoctor) {
          update();
        } else if(userPermission.isAccountant) {
          analysisModel.editAnalysis(widget.analysis);
          navigateToEditAnalysisScreen();
        }
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
