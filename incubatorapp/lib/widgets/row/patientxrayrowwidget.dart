import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/screens/patientxrayscreen/editpatientxrayscreen.dart';

class PatientXRayRowWidget extends StatefulWidget {
  final PatientXRay patientXRay;
  PatientXRayRowWidget({
    this.patientXRay,
  });
  @override
  _PatientXRayRowWidgetState createState() => _PatientXRayRowWidgetState();
}

class _PatientXRayRowWidgetState extends State<PatientXRayRowWidget> {
  Widget displayRow(String title, String val) {
    return Row(
      children: [
        Container(child: Text(title), width: 80,),
        Container(
          child: Text(
            val,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  String dateFormat() {
    String v = widget.patientXRay.createdDate.day.toString();
    v = v + '/' + widget.patientXRay.createdDate.month.toString();
    v = v + '/' + widget.patientXRay.createdDate.year.toString();
    return v;
  }

  Widget patientLaboratoryRow(XRay xRay) {
    Widget xRayNameWidget = displayRow('Name:', xRay.name);

    Widget priceWidget = displayRow('Price:', xRay.price.toString());

    Widget resultWidget = displayRow('Comment:', widget.patientXRay.comment);

    Widget createdDateWidget = displayRow('Date:', dateFormat());

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: xRayNameWidget,
        ),
        (userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: priceWidget,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        ),
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

    Widget cardGesture = GestureDetector(
      child: displayCard,
      onTap: (){
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
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: cardGesture,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Container();

    if (xRayModel.xRayList != null) {
      if (xRayModel.xRayList.length > 0) {
        int index = xRayModel.xRayList
            .indexWhere((element) => element.id == widget.patientXRay.xRayId);
        if (index >= 0) {
          XRay xRay = xRayModel.xRayList[index];

          currentWidget = patientLaboratoryRow(xRay);
        }
      }
    }
    return currentWidget;
  }
}
