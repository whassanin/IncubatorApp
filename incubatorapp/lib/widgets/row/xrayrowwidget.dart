import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/models/patient.dart';

class XRayRowWidget extends StatefulWidget {
  final Patient patient;
  final XRay xRay;
  final UserPermission userPermission;
  XRayRowWidget({this.patient, this.xRay, this.userPermission});
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

  void validate() {
    String dn = dateFormat(DateTime.now());

    int i = patientXRayModel.patientXRayList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.xRayId == widget.xRay.id &&
            dateFormat(element.createdDate) == dn);
    if (i >= 0) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  void save() {
    patientXRayModel.createPatientXRay();
    patientXRayModel.setPatientId(widget.patient.id);
    patientXRayModel.setXRayId(widget.xRay.id);
    patientXRayModel.create();
  }

  void delete() {
    String dn = dateFormat(DateTime.now());

    patientXRayModel.createPatientXRay();
    patientXRayModel.setPatientId(widget.patient.id);
    patientXRayModel.setXRayId(widget.xRay.id);

    int i = patientXRayModel.patientXRayList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.xRayId == widget.xRay.id &&
            dateFormat(element.createdDate) == dn);

    if(i >= 0){
      isSelected = true;
      patientXRayModel.editPatientXRay(patientXRayModel.patientXRayList[i]);
      patientXRayModel.delete();
    }

  }

  Widget row() {
    validate();

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.xRay.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.xRay.name,
            ),
          ),
        ),
        (widget.userPermission.isDoctor
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  if (b == true) {
                    save();
                  } else {
                    delete();
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
