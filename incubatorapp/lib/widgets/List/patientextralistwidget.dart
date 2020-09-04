import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/extra.dart';
import 'package:incubatorapp/models/patientextra.dart';
import 'package:incubatorapp/widgets/row/patientextrarowwidget.dart';

class PatientExtraListWidget extends StatefulWidget {
  final List<PatientExtra> patientExtraList;
  PatientExtraListWidget({this.patientExtraList,});

  @override
  _PatientExtraListWidgetState createState() =>
      _PatientExtraListWidgetState();
}

class _PatientExtraListWidgetState extends State<PatientExtraListWidget> {
  List<PatientExtra> addCalculatedList = [];

  double calculate() {
    double total = 0;

    if (extraModel.extraList != null) {
      if (widget.patientExtraList != null) {
        if (widget.patientExtraList.length > 0) {
          widget.patientExtraList.forEach(
                (pa) {
              int index = addCalculatedList.indexOf(pa);
              if (index < 0) {
                Extra extra = extraModel.extraList
                    .where((a) => a.id == pa.extraId)
                    .toList()[0];
                total += extra.price;
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

    if (widget.patientExtraList != null) {
      if (widget.patientExtraList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.patientExtraList.length,
          itemBuilder: (BuildContext context, int i) {
            return PatientExtraRowWidget(
              patientExtra: widget.patientExtraList[i],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Extra(s) Available'),
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
