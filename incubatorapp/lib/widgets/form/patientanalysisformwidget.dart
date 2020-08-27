import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patientanalysis.dart';

class PatientAnalysisFormWidget extends StatefulWidget {
  final PatientAnalysis patientAnalysis;
  final Analysis analysis;
  PatientAnalysisFormWidget({this.patientAnalysis, this.analysis});
  @override
  _PatientAnalysisFormWidgetState createState() =>
      _PatientAnalysisFormWidgetState();
}

class _PatientAnalysisFormWidgetState extends State<PatientAnalysisFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController resultTEC = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.analysis.name;
    resultTEC.text = widget.patientAnalysis.result;
  }

  @override
  Widget build(BuildContext context) {
    Widget nameTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: nameTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Analysis Name',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {
              },
              onFieldSubmitted: (v) {
              },
            ),
          ),
        )
      ],
    );

    Widget resultTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: resultTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Result',
              ),
              validator: (v) {
                if(v.isEmpty){
                  return 'Required';
                }
                return null;
              },
              onChanged: (v) {
                patientAnalysisModel.setResult(v);
              },
              onFieldSubmitted: (v) {
                patientAnalysisModel.setResult(v);
              },
            ),
          ),
        )
      ],
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Text('Delete', style: TextStyle(color: Colors.white)),
          onPressed: () {
            patientAnalysisModel.delete();
            Navigator.pop(context);
          },
        ),
      ),
    );

    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Text('Save', style: TextStyle(color: Colors.white)),
          onPressed: () {
            patientAnalysisModel.update();
            Navigator.pop(context);
          },
        ),
      ),
    );

    Widget updateButtonsWidget = Row(
      children: <Widget>[
        deleteButton,
        saveButton,
      ],
    );

    Widget rowWidget = Column(
      children: <Widget>[nameTextField, resultTextField, updateButtonsWidget],
    );

    return rowWidget;
  }
}
