import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/screens/xrayscreen/editpatientxrayscreen.dart';

class PatientXRayRowWidget extends StatefulWidget {
  final PatientXRay patientXRay;
  final UserPermission userPermission;
  PatientXRayRowWidget({this.patientXRay, this.userPermission});
  @override
  _PatientXRayRowWidgetState createState() => _PatientXRayRowWidgetState();
}

class _PatientXRayRowWidgetState extends State<PatientXRayRowWidget> {
  String dateFormat() {
    String v = widget.patientXRay.createdDate.day.toString();
    v = v + '/' + widget.patientXRay.createdDate.month.toString();
    v = v + '/' + widget.patientXRay.createdDate.year.toString();
    return v;
  }

  Widget patientAnalysisRow(XRay xRay) {
    Widget xRayNameWidget = Container(
      child: Text('Name: ' + xRay.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + xRay.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Comment: ' + widget.patientXRay.comment),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: ' + dateFormat()),
    );

    Widget editButtonWidget = Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Edit'),
            onPressed: () {
              patientXRayModel.editPatientXRay(widget.patientXRay);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPatientXRayScreen(
                    patientXRay: widget.patientXRay,
                    xRay: xRay,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: xRayNameWidget,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
        ),
        (widget.userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: priceWidget,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        ),
        (widget.userPermission.isDoctor ? editButtonWidget : Container())
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayCol,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      )),
      elevation: 4,
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: displayCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Container();

    if (xRayModel.xRayList != null) {
      if (xRayModel.xRayList.length > 0) {
        XRay xRay = xRayModel.xRayList
            .where((element) => element.id == widget.patientXRay.xRayId)
            .toList()[0];

        currentWidget = patientAnalysisRow(xRay);
      }
    }
    return currentWidget;
  }
}
