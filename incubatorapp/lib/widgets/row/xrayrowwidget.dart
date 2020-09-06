import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/xrayscreen/editxrayscreen.dart';

class XRayRowWidget extends StatefulWidget {
  final Patient patient;
  final XRay xRay;
  XRayRowWidget({
    this.patient,
    this.xRay,
  });
  @override
  _XRayRowWidgetState createState() => _XRayRowWidgetState();
}

class _XRayRowWidgetState extends State<XRayRowWidget> {
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

  void navigateToEditXRayScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditXRayScreen()));
  }

  int findXRay() {
    String dn = dateFormat(DateTime.now());
    int index = -1;
    patientXRayModel.patientXRayList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.xRayId == widget.xRay.id &&
          dateFormat(element.createdDate) == dn) {
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
    int index = -1;
    if (widget.patient != null) {
      index = findXRay();
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
            child: Text(widget.xRay.name, style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.xRay.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
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
        } else if (userPermission.isAccountant) {
          xRayModel.editXRay(widget.xRay);
          print('Name:' + xRayModel.getName());
          navigateToEditXRayScreen();
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
