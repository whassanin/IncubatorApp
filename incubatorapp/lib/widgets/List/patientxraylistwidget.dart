import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/widgets/row/patientxrayrowwidget.dart';

class PatientXRayListWidget extends StatefulWidget {
  final List<PatientXRay> patientXRayList;
  PatientXRayListWidget({
    this.patientXRayList,
  });

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
            int ix = xRayModel.xRayList.indexWhere((x) => x.id == px.xRayId);

            if (ix >= 0) {
              XRay xRay = xRayModel.xRayList[ix];

              total += xRay.price;
            }
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
        if (patientXRayModel.isAdding == false) {
          currentWidget = ListView.builder(
            itemCount: widget.patientXRayList.length,
            itemBuilder: (BuildContext context, int i) {
              return PatientXRayRowWidget(
                patientXRay: widget.patientXRayList[i],
              );
            },
          );
        }
      } else {
        if (patientXRayModel.isAdding == false) {
          currentWidget = Center(
            child: Container(
              child: Text('No XRay(s) Available'),
            ),
          );
        }
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('Loading...'),
        ),
      );
    }

    if (userPermission.isPatient) {
      currentWidget = Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: currentWidget,
      );
    }
    return currentWidget;
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = getList();

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

    if (userPermission.isPatient) {
      calculate();
      currentWidget = Stack(
        children: <Widget>[positionList, positionTotal],
      );
    }

/*    Stack(
      children: <Widget>[
        positionList,
        (userPermission.isPatient ? positionTotal : Container()),
      ],
    );*/

    return currentWidget;
  }
}
