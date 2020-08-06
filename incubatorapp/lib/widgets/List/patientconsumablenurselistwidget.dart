import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/screens/user/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientconsumablenurserowwidget.dart';

class PatientConsumableNurseListWidget extends StatefulWidget {
  final List<PatientConsumableNurse> patientConsumableNurseList;
  final UserPermission userPermission;
  PatientConsumableNurseListWidget(
      {this.patientConsumableNurseList, this.userPermission});

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
            Consumable consumable = consumableModel.consumableList
                .where((a) => a.id == pcn.consumableId)
                .toList()[0];
            total += (consumable.price * pcn.quantity);
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
        currentWidget = ListView.builder(
          itemCount: widget.patientConsumableNurseList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientConsumableNurseRowWidget(
              patientConsumableNurse: widget.patientConsumableNurseList[i],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Consumable(s) Available'),
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
