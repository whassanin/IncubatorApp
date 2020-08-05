import 'package:flutter/material.dart';
import 'package:incubatorapp/models/patient.dart';
class PatientRowWidget extends StatefulWidget {
  final Patient patient;
  PatientRowWidget({this.patient});
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

  Widget patientContent(String title,String val){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide.none,
          left: BorderSide(width: 1, color: Colors.black),
          bottom: BorderSide(width: 1, color: Colors.black),
          right: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(right: 10),
             child: Container(
               child: Text(title,style: TextStyle(fontSize: 14),),
             ),
           ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(val,style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(){
    Widget contentCol = Column(
      children: <Widget>[
        patientContent('Mother Name', widget.patient.motherName),
        patientContent('Father Name', widget.patient.fatherName),
        patientContent('Gender Name', (widget.patient.gender?'Male':'Female')),
        patientContent('Entered Date', dateFormat(widget.patient.createdDate)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Card(
        child: contentCol,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        elevation: 5,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return getRow();
  }
}
