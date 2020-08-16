import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/shift.dart';

enum NurseShiftColumns { shift, schedule, startDateTime, endDateTime }

class NurseShiftFormWidget extends StatefulWidget {
  final bool isEdit;
  NurseShiftFormWidget({this.isEdit});
  @override
  _NurseShiftFormWidgetState createState() => _NurseShiftFormWidgetState();
}

class _NurseShiftFormWidgetState extends State<NurseShiftFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController shiftTEC = new TextEditingController();
  TextEditingController scheduleDateTimeTEC = new TextEditingController();
  TextEditingController startDateTimeTEC = new TextEditingController();
  TextEditingController endDateTimeTEC = new TextEditingController();

  void setData(NurseShiftColumns nurseShiftColumns, Object val) {
    if (nurseShiftColumns == NurseShiftColumns.shift) {
      nurseShiftModel.setShiftId(val);
    } else if (nurseShiftColumns == NurseShiftColumns.schedule) {
      nurseShiftModel.setScheduleDateTime(val);
    } else if (nurseShiftColumns == NurseShiftColumns.startDateTime) {
      nurseShiftModel.setStartDateTime(val);
    } else if (nurseShiftColumns == NurseShiftColumns.endDateTime) {
      nurseShiftModel.setEndDateTime(val);
    }

    if (widget.isEdit != null) {
      if (widget.isEdit == true) {
        nurseShiftModel.setChangedDateTime(DateTime.now());
      } else {
        nurseShiftModel.setCreatedDateTime(DateTime.now());
      }
    }
  }

  String formatDate(DateTime dateTime, bool isTime) {
    String d = dateTime.day.toString();
    d = d + '/' + dateTime.month.toString();
    d = d + '/' + dateTime.year.toString();
    if (isTime) {
      d = d + '   '+ dateTime.hour.toString();
      d = d + ':' + dateTime.minute.toString();
      d = d + ':' + dateTime.second.toString();
    }
    return d;
  }

  void getData() {
    if (widget.isEdit) {
      Shift selectedShift = shiftModel.shiftList
          .where((element) => element.id == nurseShiftModel.getShiftId())
          .toList()[0];

      shiftTEC.text = selectedShift.name;
      scheduleDateTimeTEC.text = formatDate(nurseShiftModel.getStartDateTime(),false);
      startDateTimeTEC.text = formatDate(nurseShiftModel.getStartDateTime(),true);
      endDateTimeTEC.text = formatDate(nurseShiftModel.getEndDateTime(),true);
    }
  }

  void schedule() {
    nurseShiftModel.setNurseId(nurseModel.currentNurse.userId);
    nurseShiftModel.create();
  }

  void reSchedule() {
    nurseShiftModel.update();
  }

  void checkIn() {
    var currentDate = DateTime.now();
    setData(NurseShiftColumns.startDateTime, currentDate);
    nurseShiftModel.update();
  }

  void checkOut() {
    var currentDate = DateTime.now();
    setData(NurseShiftColumns.endDateTime, currentDate);
    nurseShiftModel.update();
  }

  void delete() {}

  void showDialogShiftList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 300,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int i) =>
                        Divider(),
                    itemCount: shiftModel.shiftList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        title: Text(
                          shiftModel.shiftList[i].name,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          shiftTEC.text = shiftModel.shiftList[i].name;
                          setData(NurseShiftColumns.shift,
                              shiftModel.shiftList[i].id);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogScheduleDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 150,
              child: CalendarDatePicker(
                firstDate: DateTime.now().subtract(Duration(days: 356)),
                initialDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 356)),
                onDateChanged: (d) {
                  String v = d.day.toString();
                  v = v + '/' + d.month.toString();
                  v = v + '/' + d.year.toString();

                  scheduleDateTimeTEC.text = v;
                  setData(NurseShiftColumns.schedule, d);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showDialogStartDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 150,
              child: CalendarDatePicker(
                firstDate: DateTime.now().subtract(Duration(days: 356)),
                initialDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 356)),
                onDateChanged: (d) {
                  String v = d.day.toString();
                  v = v + '/' + d.month.toString();
                  v = v + '/' + d.year.toString();

                  startDateTimeTEC.text = v;
                  setData(NurseShiftColumns.startDateTime, d);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showDialogEndDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 150,
              child: CalendarDatePicker(
                firstDate: DateTime.now().subtract(Duration(days: 356)),
                initialDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 356)),
                onDateChanged: (d) {
                  String v = d.day.toString();
                  v = v + '/' + d.month.toString();
                  v = v + '/' + d.year.toString();

                  endDateTimeTEC.text = v;
                  setData(NurseShiftColumns.endDateTime, d);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget columnTextField(String name, bool isNumber,
      NurseShiftColumns nurseShiftColumns, TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: columnTEC,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          labelText: name,
        ),
        readOnly: (fun != null ? true : false),
        keyboardType: (isNumber ? TextInputType.number : null),
        inputFormatters: (isNumber
            ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            : null),
        validator: (v) {
          return null;
        },
        onChanged: (v) {},
        onFieldSubmitted: (v) {},
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  Widget editButtons(String title, VoidCallback fun) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(title),
            onPressed: () {
              if (fun != null) {
                fun();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    Widget scheduleButton = Container();
    Widget checkInButton = Container();
    Widget checkOutButton = Container();
    Widget deleteButton = Container();

    if (widget.isEdit) {
      String currentDate = formatDate(
          DateTime.now(),
          false
      );
      String pendingDate = formatDate(
          nurseShiftModel.currentNurseShift.startDateTime,
          false
      );

      if (currentDate == pendingDate) {
        if (nurseShiftModel.currentNurseShift.isSignedIn) {
          if (nurseShiftModel.currentNurseShift.isSignedOut) {
            deleteButton = Container();
          } else {
            checkOutButton = editButtons('Check Out', checkOut);
          }
        } else {
          deleteButton = editButtons('Delete', delete);
          checkInButton = editButtons('Check In', checkIn);
        }
      } else {
        deleteButton = editButtons('Delete', delete);
        scheduleButton = editButtons('Reschedule', reSchedule);
      }
    } else {
      scheduleButton = editButtons('Schedule', schedule);
    }

    Widget editButtonRow = Row(
      children: <Widget>[
        deleteButton,
        scheduleButton,
        checkInButton,
        checkOutButton,
      ],
    );

    Widget scheduleDateTimeTFF = Container();
    Widget startDateTimeTFF = Container();
    Widget endDateTimeTFF = Container();

    if (widget.isEdit) {
      if (nurseShiftModel.currentNurseShift.isSignedIn) {
        startDateTimeTFF = columnTextField('Start Date', false,
            NurseShiftColumns.startDateTime, startDateTimeTEC,
            fun: showDialogStartDatePicker);
        if (nurseShiftModel.currentNurseShift.isSignedOut) {
          endDateTimeTFF = columnTextField(
              'End Date', false, NurseShiftColumns.endDateTime, endDateTimeTEC,
              fun: showDialogEndDatePicker);
        }
      } else {
        scheduleDateTimeTFF = columnTextField('Schedule Date', false,
            NurseShiftColumns.schedule, scheduleDateTimeTEC,
            fun: showDialogScheduleDatePicker);
      }
    } else {
      scheduleDateTimeTFF = columnTextField('Schedule Date', false,
          NurseShiftColumns.schedule, scheduleDateTimeTEC,
          fun: showDialogScheduleDatePicker);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          columnTextField('Shift', false, NurseShiftColumns.shift, shiftTEC,
              fun: showDialogShiftList),
          scheduleDateTimeTFF,
          startDateTimeTFF,
          endDateTimeTFF,
          editButtonRow
        ],
      ),
    );
  }
}