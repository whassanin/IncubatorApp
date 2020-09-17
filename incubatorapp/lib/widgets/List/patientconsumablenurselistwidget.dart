import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientconsumablenurserowwidget.dart';

class PatientConsumableNurseListWidget extends StatefulWidget {
  final Patient patient;
  final List<PatientConsumableNurse> patientConsumableNurseList;
  final UserPermission userPermission;
  PatientConsumableNurseListWidget(
      {this.patient, this.patientConsumableNurseList, this.userPermission});

  @override
  _PatientConsumableNurseListWidgetState createState() =>
      _PatientConsumableNurseListWidgetState();
}

class _PatientConsumableNurseListWidgetState
    extends State<PatientConsumableNurseListWidget> {
  List<PatientConsumableNurse> addCalculatedList = [];

  double calculate() {
    double total = 0;
    if (widget.patientConsumableNurseList != null) {
      if (widget.patientConsumableNurseList.length > 0) {
        widget.patientConsumableNurseList.forEach((pcn) {
          int index = addCalculatedList.indexOf(pcn);

          if (index < 0) {
            int ic = consumableModel.consumableList
                .indexWhere((a) => a.id == pcn.consumableId);

            if (ic >= 0) {
              Consumable consumable = consumableModel.consumableList[ic];

              total += (consumable.price * pcn.quantity);
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

    if (widget.patientConsumableNurseList != null) {
      if (widget.patientConsumableNurseList.length > 0) {
        if (patientConsumableNurseModel.isAdding == false) {
          currentWidget = ListView.builder(
            itemCount: widget.patientConsumableNurseList.length,
            itemBuilder: (BuildContext context, int i) {
              return PatientConsumableNurseRowWidget(
                patientConsumableNurse: widget.patientConsumableNurseList[i],
                userPermission: widget.userPermission,
              );
            },
          );
        }
      } else {
        if (patientConsumableNurseModel.isAdding == false) {
          currentWidget = Center(
            child: Container(
              child: Text('No Consumable(s) Available'),
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
