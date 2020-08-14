import 'package:flutter/material.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:incubatorapp/widgets/row/nurseshiftrowwidget.dart';

class NurseShiftListWidget extends StatefulWidget {
  final List<NurseShift> nurseShiftList;

  NurseShiftListWidget({this.nurseShiftList});

  @override
  _NurseShiftListWidgetState createState() => _NurseShiftListWidgetState();
}

class _NurseShiftListWidgetState extends State<NurseShiftListWidget> {
  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.nurseShiftList != null) {
      if (widget.nurseShiftList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.nurseShiftList.length,
          itemBuilder: (BuildContext context, int i) {
            return NurseShiftRowWidget(
              nurseShift: widget.nurseShiftList[i],
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
