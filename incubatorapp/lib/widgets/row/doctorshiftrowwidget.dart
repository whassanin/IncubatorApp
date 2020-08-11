import 'package:flutter/material.dart';
import 'package:incubatorapp/models/doctorshift.dart';

class DoctorShiftRowWidget extends StatefulWidget {
  final DoctorShift doctorShift;
  DoctorShiftRowWidget({this.doctorShift});
  @override
  _DoctorShiftRowWidgetState createState() => _DoctorShiftRowWidgetState();
}

class _DoctorShiftRowWidgetState extends State<DoctorShiftRowWidget> {
  Widget row() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(widget.doctorShift.shiftId.toString()),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(widget.doctorShift.shiftId.toString()),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(widget.doctorShift.shiftId.toString()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
