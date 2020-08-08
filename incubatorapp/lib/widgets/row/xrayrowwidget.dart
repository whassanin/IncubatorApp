import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
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

  Widget row() {
    PatientXRay selectedPatientXRay;
    List<PatientXRay> selectedList = patientXRayModel.patientXRayList
        .where((pa) => pa.xRayId == widget.xRay.id)
        .toList();

    if (selectedList.length > 0) {
      isSelected = true;
      selectedPatientXRay = selectedList[0];
    }

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
                    patientXRayModel.createPatientXRay();
                    patientXRayModel.setPatientId(widget.patient.id);
                    patientXRayModel.setXRayId(widget.xRay.id);
                    patientXRayModel.create();
                  } else {
                    patientXRayModel.editPatientXRay(selectedPatientXRay);
                    patientXRayModel.delete();
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
