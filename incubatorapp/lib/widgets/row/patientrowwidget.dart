import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/patientscreen/patientdetailscreen.dart';

class PatientRowWidget extends StatefulWidget {
  final Patient patient;
  PatientRowWidget({
    this.patient,
  });
  @override
  _PatientRowWidgetState createState() => _PatientRowWidgetState();
}

class _PatientRowWidgetState extends State<PatientRowWidget> {
  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  Widget patientContent(String title, String val) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(width: 1, color: Colors.black),
          left: BorderSide(width: 1, color: Colors.black),
          bottom: BorderSide(width: 1, color: Colors.black),
          right: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val, style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow() {
    Condition condition;

    if (conditionModel.conditionList != null) {
      List<Condition> list = conditionModel.conditionList
          .where((c) => c.id == widget.patient.conditionId)
          .toList();
      if (list.length > 0) {
        condition = list[0];
      }
    }

    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    Widget contentCol = Column(
      children: <Widget>[
        patientContent('Mother Name:', widget.patient.motherName),
        patientContent('Father Name:', widget.patient.fatherName),
        patientContent('Gender :', (widget.patient.gender ? 'Male' : 'Female')),
        patientContent('Entered Date:', dateFormat(widget.patient.createdDate)),
        patientContent(
            'Incubator number:', widget.patient.incubatorId.toString()),
        (condition != null
            ? patientContent('Condition:', condition.name)
            : Container()),
      ],
    );

    if (condition != null) {
      currentWidget = contentCol;
    }

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: contentCol,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          elevation: 5,
        ),
      ),
      onTap: () {
        patientModel.editPatient(widget.patient);
        if (userPermission.isDoctor || userPermission.isNurse) {
          patientModel.readById(widget.patient.userId.toString(), 0, 1, false);
        } else if (userPermission.isFrontDesk) {
          patientModel.readById(widget.patient.userId.toString(), 1, 0, false);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientDetailScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getRow();
  }
}
