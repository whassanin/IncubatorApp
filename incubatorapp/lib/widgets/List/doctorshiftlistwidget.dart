import 'package:flutter/material.dart';
import 'package:incubatorapp/models/doctorshift.dart';
import 'package:incubatorapp/widgets/row/doctorshiftrowwidget.dart';

class DoctorShiftListWidget extends StatefulWidget {
  final List<DoctorShift> doctorShiftList;

  DoctorShiftListWidget({this.doctorShiftList});

  @override
  _DoctorShiftListWidgetState createState() => _DoctorShiftListWidgetState();
}

class _DoctorShiftListWidgetState extends State<DoctorShiftListWidget> {
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

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }
}
