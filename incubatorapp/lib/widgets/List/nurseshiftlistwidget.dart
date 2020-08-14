import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:incubatorapp/widgets/row/nurseshiftrowwidget.dart';

class NurseShiftListWidget extends StatefulWidget {
  final List<NurseShift> nurseShiftList;

  NurseShiftListWidget({this.nurseShiftList});

  @override
  _NurseShiftListWidgetState createState() => _NurseShiftListWidgetState();
}

class _NurseShiftListWidgetState extends State<NurseShiftListWidget> {
  double calculate() {
    double total = 0;
    if (widget.nurseShiftList != null) {
      if (widget.nurseShiftList.length > 0) {
        widget.nurseShiftList.forEach((element) {
          if (element.isSignedIn == true && element.isSignedOut == true) {
            total += nurseShiftModel.totalHours(
                element.startDateTime, element.endDateTime);
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
