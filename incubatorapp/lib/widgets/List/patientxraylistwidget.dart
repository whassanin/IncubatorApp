import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/screens/user/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientxrayrowwidget.dart';

class PatientXRayListWidget extends StatefulWidget {
  final List<PatientXRay> patientXRayList;
  final UserPermission userPermission;
  PatientXRayListWidget({this.patientXRayList, this.userPermission});

  @override
  _PatientXRayListWidgetState createState() => _PatientXRayListWidgetState();
}

class _PatientXRayListWidgetState extends State<PatientXRayListWidget> {
  List<PatientXRay> addCalculatedList = [];

  double calculate() {
    double total = 0;
    if (widget.patientXRayList != null) {
      if (widget.patientXRayList.length > 0) {
        widget.patientXRayList.forEach((px) {
          int index = addCalculatedList.indexOf(px);

          if (index < 0) {
            XRay xRay =
                xRayModel.xRayList.where((x) => x.id == px.xRayId).toList()[0];
            total += xRay.price;
          }
        });
      }
    }
    return total;
  }

  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.patientXRayList != null) {
      if (widget.patientXRayList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.patientXRayList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientXRayRowWidget(
              patientXRay: widget.patientXRayList[i],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No XRay(s) Available'),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: currentWidget,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    calculate();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: getList()));

    Widget positionTotal = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Text(
              'Total: ' + calculate().toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        positionList,
        (widget.userPermission.isPatient ? positionTotal : Container()),
      ],
    );
  }
}
