import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:incubatorapp/models/shift.dart';
import 'package:incubatorapp/screens/shiftscreen/editnurseshiftscreen.dart';

class NurseShiftRowWidget extends StatefulWidget {
  final NurseShift nurseShift;
  NurseShiftRowWidget({this.nurseShift});
  @override
  _NurseShiftRowWidgetState createState() => _NurseShiftRowWidgetState();
}

class _NurseShiftRowWidgetState extends State<NurseShiftRowWidget> {
  String formatDate(DateTime dateTime) {
    String d = dateTime.day.toString();
    d = d + '/' + dateTime.month.toString();
    d = d + '/' + dateTime.year.toString();
    return d;
  }

  String formatTime(DateTime dateTime) {
    String d = dateTime.hour.toString();
    d = d + ':' + dateTime.minute.toString();
    d = d + ':' + dateTime.second.toString();
    return d;
  }

  Widget row(String shiftName, DateTime startDateTime, DateTime endDateTime) {
    String cd = formatDate(DateTime.now());

    String sd = formatDate(startDateTime);

    String st = formatTime(startDateTime);

    String ed = formatDate(endDateTime);

    String et = formatTime(endDateTime);

    Decoration decoration = BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black,
      ),
    );

    Widget startDateText = Container(
      child: Center(child: Text('Date: ' + sd)),
      decoration: decoration,
    );
    Widget startTimeText = Container(
      child: Center(child: Text('Time: ' + st)),
      decoration: decoration,
    );

    Widget startDateGridView = GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 4,
      children: <Widget>[startDateText, startTimeText],
    );

    Widget startDateTitle = Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text('Start')),
      ),
      decoration: decoration,
    );

    Widget startDateTimeRow = GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: <Widget>[startDateTitle, startDateGridView],
    );

    Widget endDateText = Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text('Date:' + ed),
        ),
      ),
      decoration: decoration,
    );
    Widget endTimeText = Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text('Time: ' + et),
        ),
      ),
      decoration: decoration,
    );

    Widget endDateGridView = GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 4,
      children: <Widget>[endDateText, endTimeText],
    );

    Widget endDateTitle = Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text('End')),
      ),
      decoration: decoration,
    );

    Widget endDateTimeRow = GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: <Widget>[
        endDateTitle,
        endDateGridView,
      ],
    );

    Widget shiftTitle = Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text('Shift: ' + shiftName)),
      ),
      decoration: decoration,
    );

    Widget totalHoursRow = Container(
      decoration: decoration,
      child: Center(
        child: Text('Total Hours: ' +
            nurseShiftModel
                .totalHours(widget.nurseShift.startDateTime,
                    widget.nurseShift.endDateTime)
                .toString()),
      ),
    );

    Widget dateTimeRow = GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 4,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        shiftTitle,
        startDateTimeRow,
        endDateTimeRow,
        totalHoursRow,
      ],
    );

    Widget pendingMessageContainer = Container(
      decoration: decoration,
      child: Center(
        child: Text('Pending Date: '+sd),
      ),
    );

    Widget notSignedMessageContainer = Container(
      decoration: decoration,
      child: Center(
        child: Text('Not Checked In'),
      ),
    );

    Widget currentMessageContainer = pendingMessageContainer;

    if(sd == cd){
      currentMessageContainer = notSignedMessageContainer;
    }

    Widget notSignedInWidget = GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        shiftTitle,
        currentMessageContainer,
      ],
    );

    Widget current = notSignedInWidget;

    if (widget.nurseShift.isSignedIn) {
      current = dateTimeRow;
    }

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(),
          child: current,
        ),
      ),
      onTap: () {
        nurseShiftModel.editNurseShift(widget.nurseShift);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditNurseShiftScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Shift selectedShift = shiftModel.shiftList
        .where((element) => element.id == widget.nurseShift.shiftId)
        .toList()[0];

    return row(
      selectedShift.name,
      widget.nurseShift.startDateTime,
      widget.nurseShift.endDateTime,
    );
  }
}
