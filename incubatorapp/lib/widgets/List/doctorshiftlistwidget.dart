import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/doctorshift.dart';
import 'package:incubatorapp/widgets/row/doctorshiftrowwidget.dart';

class DoctorShiftListWidget extends StatefulWidget {
  final List<DoctorShift> doctorShiftList;
  DoctorShiftListWidget({this.doctorShiftList});

  @override
  _DoctorShiftListWidgetState createState() => _DoctorShiftListWidgetState();
}

class _DoctorShiftListWidgetState extends State<DoctorShiftListWidget> {
  double calculate() {
    double total = doctorShiftModel.calculate();
    return total;
  }

  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.doctorShiftList != null) {
      if (widget.doctorShiftList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.doctorShiftList.length,
          itemBuilder: (BuildContext context, int i) {
            return DoctorShiftRowWidget(
              doctorShift: widget.doctorShiftList[i],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Shift(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Shift(s) Available'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: currentWidget,
    );
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
      children: <Widget>[positionList, positionTotal],
    );
  }
}
