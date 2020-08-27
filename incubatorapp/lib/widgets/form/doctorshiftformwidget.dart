import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/shift.dart';

enum DoctorShiftColumns { shift, schedule, startDateTime, endDateTime }

class DoctorShiftFormWidget extends StatefulWidget {
  final bool isEdit;
  DoctorShiftFormWidget({this.isEdit});
  @override
  _DoctorShiftFormWidgetState createState() => _DoctorShiftFormWidgetState();
}

class _DoctorShiftFormWidgetState extends State<DoctorShiftFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController shiftTEC = new TextEditingController();
  TextEditingController scheduleDateTimeTEC = new TextEditingController();
  TextEditingController startDateTimeTEC = new TextEditingController();
  TextEditingController endDateTimeTEC = new TextEditingController();

  void setData(DoctorShiftColumns doctorShiftColumns, Object val) {
    if (doctorShiftColumns == DoctorShiftColumns.shift) {
      doctorShiftModel.setShiftId(val);
    } else if (doctorShiftColumns == DoctorShiftColumns.schedule) {
      doctorShiftModel.setScheduleDateTime(val);
    } else if (doctorShiftColumns == DoctorShiftColumns.startDateTime) {
      doctorShiftModel.setStartDateTime(val);
    } else if (doctorShiftColumns == DoctorShiftColumns.endDateTime) {
      doctorShiftModel.setEndDateTime(val);
    }

    if (widget.isEdit != null) {
      if (widget.isEdit == true) {
        doctorShiftModel.setChangedDateTime(DateTime.now());
      } else {
        doctorShiftModel.setCreatedDateTime(DateTime.now());
      }
    }
  }

  String formatDate(DateTime dateTime, bool isTime) {
    String d = dateTime.day.toString();
    d = d + '/' + dateTime.month.toString();
    d = d + '/' + dateTime.year.toString();
    if (isTime) {
      d = d + '   ' + dateTime.hour.toString();
      d = d + ':' + dateTime.minute.toString();
      d = d + ':' + dateTime.second.toString();
    }
    return d;
  }

  void getData() {
    if (widget.isEdit) {
      Shift selectedShift = shiftModel.shiftList
          .where((element) => element.id == doctorShiftModel.getShiftId())
          .toList()[0];

      shiftTEC.text = selectedShift.name;
      scheduleDateTimeTEC.text =
          formatDate(doctorShiftModel.getStartDateTime(), false);
      startDateTimeTEC.text =
          formatDate(doctorShiftModel.getStartDateTime(), true);
      endDateTimeTEC.text = formatDate(doctorShiftModel.getEndDateTime(), true);
    }
  }

  void schedule() {
    if (_formKey.currentState.validate()) {
      doctorShiftModel.setDoctorId(doctorModel.currentDoctor.userId);
      doctorShiftModel.create();
    }
  }

  void reSchedule() {
    if (_formKey.currentState.validate()) {
      doctorShiftModel.update();
    }
  }

  void checkIn() {
    if (_formKey.currentState.validate()) {
      var currentDate = DateTime.now();
      setData(DoctorShiftColumns.startDateTime, currentDate);
      doctorShiftModel.update();
    }
  }

  void checkOut() {
    var currentDate = DateTime.now();
    setData(DoctorShiftColumns.endDateTime, currentDate);
    doctorShiftModel.update();
  }

  void delete() {}

  void showDialogShiftList() {
    Widget currentWidget = Container();

    if (shiftModel.shiftList != null) {
      if (shiftModel.shiftList.length > 0) {
        currentWidget = ListView.separated(
          separatorBuilder: (BuildContext context, int i) => Divider(),
          itemCount: shiftModel.shiftList.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              title: Text(
                shiftModel.shiftList[i].name,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                shiftTEC.text = shiftModel.shiftList[i].name;
                setData(DoctorShiftColumns.shift, shiftModel.shiftList[i].id);
                Navigator.pop(context);
              },
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Shift Titles Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Shift Titles Available'),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 250,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 250,
                  child: currentWidget,
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
                  setData(DoctorShiftColumns.schedule, d);
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
                  setData(DoctorShiftColumns.startDateTime, d);
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
                  setData(DoctorShiftColumns.endDateTime, d);
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
      DoctorShiftColumns doctorShiftColumns, TextEditingController columnTEC,
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
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(title, style: TextStyle(color: Colors.white)),
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
      String currentDate = formatDate(DateTime.now(), false);
      String pendingDate =
          formatDate(doctorShiftModel.currentDoctorShift.startDateTime, false);

      if (currentDate == pendingDate) {
        if (doctorShiftModel.currentDoctorShift.isSignedIn) {
          if (doctorShiftModel.currentDoctorShift.isSignedOut) {
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
      if (doctorShiftModel.currentDoctorShift.isSignedIn) {
        startDateTimeTFF = columnTextField('Start Date', false,
            DoctorShiftColumns.startDateTime, startDateTimeTEC,
            fun: showDialogStartDatePicker);
        if (doctorShiftModel.currentDoctorShift.isSignedOut) {
          endDateTimeTFF = columnTextField(
              'End Date', false, DoctorShiftColumns.endDateTime, endDateTimeTEC,
              fun: showDialogEndDatePicker);
        }
      } else {
        scheduleDateTimeTFF = columnTextField('Schedule Date', false,
            DoctorShiftColumns.schedule, scheduleDateTimeTEC,
            fun: showDialogScheduleDatePicker);
      }
    } else {
      scheduleDateTimeTFF = columnTextField('Schedule Date', false,
          DoctorShiftColumns.schedule, scheduleDateTimeTEC,
          fun: showDialogScheduleDatePicker);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          columnTextField('Shift', false, DoctorShiftColumns.shift, shiftTEC,
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
