import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientrowwidget.dart';

class PatientListWidget extends StatefulWidget {
  final List<Patient> patientList;
  PatientListWidget({this.patientList,});
  @override
  _PatientListWidgetState createState() => _PatientListWidgetState();
}

class _PatientListWidgetState extends State<PatientListWidget> {
  Widget getList() {

    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (patientModel.patientList != null) {
      if(patientModel.patientList.length > 0){
        currentWidget = ListView.builder(
          itemCount: widget.patientList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientRowWidget(
              patient: widget.patientList[i],
            );
          },
        );
      }else {
        currentWidget = Center(
          child: Container(
            child: Text('No Patient(s) Available'),
          ),
        );
      }
    }else {

    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }
}
