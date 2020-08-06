import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';

class AnalysisRowWidget extends StatefulWidget {
  final Analysis analysis;
  final bool isPatientAnalysis;
  AnalysisRowWidget({this.analysis, this.isPatientAnalysis});
  @override
  _AnalysisRowWidgetState createState() => _AnalysisRowWidgetState();
}

class _AnalysisRowWidgetState extends State<AnalysisRowWidget> {
  bool isSelected = false;

  Widget row() {
    List<PatientAnalysis> selectedList = patientAnalysisModel
        .patientAnalysisList
        .where((pa) => pa.analysisId == widget.analysis.id)
        .toList();

    if (selectedList.length > 0) {
      isSelected = true;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.analysis.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Container(child: Text('Name: ' + widget.analysis.name))),
        (widget.isPatientAnalysis
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  patientAnalysisModel.setAnalysisId(widget.analysis.id);
                  patientAnalysisModel.create();
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
        if (widget.isPatientAnalysis) {
        } else {}

        /*incubatorModel.editIncubator(widget.incubator);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditIncubatorScreen(),
          ),
        );*/
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
