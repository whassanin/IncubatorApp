import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/patientlaboratoryrowwidget.dart';

class PatientLaboratoryListWidget extends StatefulWidget {
  final List<PatientLaboratory> patientLaboratoryList;
  PatientLaboratoryListWidget({this.patientLaboratoryList,});

  @override
  _PatientLaboratoryListWidgetState createState() =>
      _PatientLaboratoryListWidgetState();
}

class _PatientLaboratoryListWidgetState extends State<PatientLaboratoryListWidget> {
  List<PatientLaboratory> addCalculatedList = [];

  double calculate() {
    double total = 0;

    if (laboratoryModel.laboratoryList != null) {
      if (widget.patientLaboratoryList != null) {
        if (widget.patientLaboratoryList.length > 0) {
          widget.patientLaboratoryList.forEach(
            (pa) {
              int index = addCalculatedList.indexOf(pa);
              if (index < 0) {

                int il = laboratoryModel.laboratoryList.indexWhere((a) => a.id == pa.laboratoryId);

                if (il >= 0){
                  Laboratory laboratory = laboratoryModel.laboratoryList[il];
                  total += laboratory.price;
                }
              }
            },
          );
        }
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

    if (widget.patientLaboratoryList != null) {
      if (widget.patientLaboratoryList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.patientLaboratoryList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientLaboratoryRowWidget(
              patientLaboratory: widget.patientLaboratoryList[i],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Laboratory(s) Available'),
          ),
        );
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

    return currentWidget;
  }
}
