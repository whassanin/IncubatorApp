import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/models/patient.dart';

class XRayRowWidget extends StatefulWidget {
  final Patient patient;
  final XRay xRay;
  XRayRowWidget({this.patient, this.xRay,});
  @override
  _XRayRowWidgetState createState() => _XRayRowWidgetState();
}

class _XRayRowWidgetState extends State<XRayRowWidget> {
  bool isSelected = false;

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void update() {
    int index = findXRay();
    if (index >= 0) {
      delete(index);
    } else if (index < 0) {
      save();
    }
  }

  int findXRay() {
    int index = -1;
    patientXRayModel.patientXRayList.forEach((element) {
      if(element.patientId == widget.patient.userId &&
          element.xRayId == widget.xRay.id){
        index = patientXRayModel.patientXRayList.indexOf(element);
      }
    });

    return index;
  }

  void delete(int index) {
    patientXRayModel.editPatientXRay(patientXRayModel.patientXRayList[index]);
    patientXRayModel.delete();
  }

  void save() {
    patientXRayModel.createPatientXRay();
    patientXRayModel.setPatientId(widget.patient.userId);
    patientXRayModel.setXRayId(widget.xRay.id);
    patientXRayModel.create();
  }

  Widget row() {

    int index = findXRay();

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if(index >= 0){
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.xRay.id.toString(),style: TextStyle(color: textColor)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.xRay.name,
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
        if (userPermission.isDoctor) {
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
