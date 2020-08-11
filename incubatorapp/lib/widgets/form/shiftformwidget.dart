import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum ShiftColumns {
  startDate,
  endDate,
}

class ShiftFormWidget extends StatefulWidget {
  final bool isEdit;
  ShiftFormWidget({this.isEdit});
  @override
  _ShiftFormWidgetState createState() => _ShiftFormWidgetState();
}

class _ShiftFormWidgetState extends State<ShiftFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController startDateTEC = new TextEditingController();
  TextEditingController endDateTEC = new TextEditingController();

  void setData(ShiftColumns shiftColumns, Object val) {
    if (shiftColumns == ShiftColumns.startDate) {
      shiftModel.setStartDate(val);
    } else if (shiftColumns == ShiftColumns.endDate) {
      shiftModel.setEndDate(val);
    }
  }

  void getData() {
    startDateTEC.text = shiftModel.getStartDate().toString();
    endDateTEC.text = shiftModel.getEndDate().toString();
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

                  startDateTEC.text = v;
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

                  endDateTEC.text = v;
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
      ShiftColumns shiftColumns, TextEditingController columnTEC,
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
        onChanged: (v) {
          setData(shiftColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(shiftColumns, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  Widget editButtons() {
    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
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
            child: Text('Save'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if (widget.isEdit != null) {
                  if (widget.isEdit) {
                    shiftModel.update();
                  } else {
                    shiftModel.create();
                  }
                }
              }
            },
          ),
        ),
      ),
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
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
            child: Text('Delete'),
            onPressed: () {},
          ),
        ),
      ),
    );

    Widget rowCreateButtons = Row(
      children: <Widget>[saveButton],
    );

    Widget rowEditButtons = Row(
      children: <Widget>[/*deleteButton*/ saveButton],
    );

    Widget rowButtons = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        rowButtons = rowEditButtons;
      } else {
        rowButtons = rowCreateButtons;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: rowButtons,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        getData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              columnTextField(
                  'First Name', false, ShiftColumns.startDate, startDateTEC),
              columnTextField(
                  'Last Name', false, ShiftColumns.endDate, endDateTEC),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
