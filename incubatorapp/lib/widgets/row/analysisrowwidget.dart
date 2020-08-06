import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/userpermission.dart';

class AnalysisRowWidget extends StatefulWidget {
  final Analysis analysis;
  final UserPermission userPermission;
  AnalysisRowWidget({this.analysis, this.userPermission});
  @override
  _AnalysisRowWidgetState createState() => _AnalysisRowWidgetState();
}

class _AnalysisRowWidgetState extends State<AnalysisRowWidget> {
  bool isSelected = false;

  Widget row() {
    PatientAnalysis selectedPatientAnalysis;
    List<PatientAnalysis> selectedList = patientAnalysisModel
        .patientAnalysisList
        .where((pa) => pa.analysisId == widget.analysis.id)
        .toList();

    if (selectedList.length > 0) {
      isSelected = true;
      selectedPatientAnalysis = selectedList[0];
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.analysis.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(child: Text('Name: ' + widget.analysis.name))),
        (widget.userPermission.isDoctor
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  if (b == true) {
                    patientAnalysisModel.createPatientAnalysis();
                    patientAnalysisModel
                        .setPatientId(patientModel.currentPatient.id);
                    patientAnalysisModel.setAnalysisId(widget.analysis.id);
                    patientAnalysisModel.create();
                  } else {
                    patientAnalysisModel
                        .editPatientAnalysis(selectedPatientAnalysis);
                    patientAnalysisModel.delete();
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
