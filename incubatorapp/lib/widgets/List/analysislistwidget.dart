import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/widgets/row/analysisrowwidget.dart';

class AnalysisListWidget extends StatefulWidget {
  final Patient patient;
  final List<Analysis> analysisList;
  AnalysisListWidget({
    this.patient,
    this.analysisList,
  });

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

    Widget searchTextField = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Search here...'),
                onChanged: (v) {
                  analysisModel.search(v);
                },
              ),
            )
          ],
        ),
      ),
    );

    if (analysisModel.searchList.length > 0) {
      currentWidget = Column(
        children: <Widget>[
          searchTextField,
          Expanded(
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: analysisModel.searchList.length,
              itemBuilder: (BuildContext context, int index) {
                return AnalysisRowWidget(
                  patient: widget.patient,
                  analysis: analysisModel.searchList[index],
                );
              },
            ),
          ),
        ],
      );
    } else if (widget.analysisList.length > 0) {
      currentWidget = Column(
        children: <Widget>[
          searchTextField,
          Expanded(
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.analysisList.length,
              itemBuilder: (BuildContext context, int index) {
                return AnalysisRowWidget(
                  patient: widget.patient,
                  analysis: widget.analysisList[index],
                );
              },
            ),
          ),
        ],
      );
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Analysis(s) Available'),
        ),
      );
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = _getList();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: _getList()));

    Widget positionSaveButton = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {
            patientAnalysisModel.readByPatientId(widget.patient.userId);
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (userPermission.isDoctor) {
      currentWidget = Stack(
        children: <Widget>[positionList, positionSaveButton],
      );
    }

    return currentWidget;
  }
}
