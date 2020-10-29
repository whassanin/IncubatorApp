import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/models/incubator.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/views/bill/billscreen/billscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientdetailscreen.dart';

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

  Widget patientContent(String title, String val, bool isFirst, bool isLast) {
    BorderRadius br;

    if (isFirst) {
      br = BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0));
    } else if (isLast) {
      br = BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0));
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: br,
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
    Incubator incubator;

    if (conditionModel.conditionList != null) {
      int index = conditionModel.conditionList
          .indexWhere((c) => c.id == widget.patient.conditionId);
      if (index > -1) {
        condition = conditionModel.conditionList[index];
      }
    }

    if (incubatorModel.incubatorList != null) {
      int index = incubatorModel.incubatorList
          .indexWhere((c) => c.id == widget.patient.incubatorId);
      if (index > -1) {
        incubator = incubatorModel.incubatorList[index];
      }
    }

    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    Widget contentCol = Column(
      children: <Widget>[
        patientContent('Mother Name:', widget.patient.motherName, true, false),
        patientContent('Father Name:', widget.patient.fatherName, false, false),
        patientContent('Gender :', (widget.patient.gender ? 'Male' : 'Female'),
            false, false),
        patientContent('Entered Date:', dateFormat(widget.patient.createdDate),
            false, false),
        patientContent('Incubator number:', incubator.name, false, false),
        (condition != null
            ? patientContent('Condition:', condition.name, false, true)
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
          patientModel.readById(widget.patient.userId.toString());

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(),
            ),
          );
        } else if (userPermission.isAccountant) {
          patientModel.readById(widget.patient.userId.toString());

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BillScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getRow();
  }
}
