import 'package:flutter/material.dart';
import 'package:incubatorapp/models/shift.dart';

class ShiftRowWidget extends StatefulWidget {
  final Shift shift;
  ShiftRowWidget({this.shift});
  @override
  _ShiftRowWidgetState createState() => _ShiftRowWidgetState();
}

class _ShiftRowWidgetState extends State<ShiftRowWidget> {
  int calculateTotalHours() {
    int m = widget.shift.startTime, n = widget.shift.endTime;
    if (widget.shift.isStartTimePM == true) {
      m = m + 12;
    }

    if (widget.shift.isEndTimePM == true) {
      n = n + 12;
    }

    int t = m - n;
    if (t < 0) {
      t = t * (-1);
    } else if (t == 0) {
      t = 24;
    }

    return t;
  }

  @override
  Widget build(BuildContext context) {
    Widget nameRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.shift.name,
      ),
    );

    String s = '';

    if (widget.shift.isStartTimePM == false) {
      s = 'AM';
    } else {
      s = 'PM';
    }

    Widget startTimeRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Start Time: ' + widget.shift.startTime.toString() + ':00 ' + s,
      ),
    );

    String e = '';

    if (widget.shift.isEndTimePM == false) {
      e = 'AM';
    } else {
      e = 'PM';
    }

    Widget endTimeRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'End Time: ' + widget.shift.endTime.toString() + ':00 ' + e,
      ),
    );

    Widget totalTimeRow = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        calculateTotalHours().toString(),
      ),
    );

    Widget dataColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        nameRow,
        startTimeRow,
        endTimeRow,
        totalTimeRow
      ],
    );

    Widget shiftCard = Card(
      child: dataColumn,
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: shiftCard,
    );
  }
}
