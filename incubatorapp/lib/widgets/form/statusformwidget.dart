import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum StatusColumns {
  heartRate,
  pulseRate,
  oxygen,
  weight,
  sugar,
  urine,
  stool,
  bloodPressure,
  temperature,
  incubatorTemperature,
}

class StatusFormWidget extends StatefulWidget {
  final bool isEdit;
  StatusFormWidget({
    this.isEdit,
  });
  @override
  _StatusFormWidgetState createState() => _StatusFormWidgetState();
}

class _StatusFormWidgetState extends State<StatusFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController heartRateTEC = new TextEditingController();
  TextEditingController pulseRateTEC = new TextEditingController();
  TextEditingController oxygenTEC = new TextEditingController();
  TextEditingController weightTEC = new TextEditingController();
  TextEditingController sugarTEC = new TextEditingController();
  TextEditingController urineTEC = new TextEditingController();
  TextEditingController stoolTEC = new TextEditingController();
  TextEditingController bloodPressureTEC = new TextEditingController();
  TextEditingController temperatureTEC = new TextEditingController();
  TextEditingController incubatorTemperatureTEC = new TextEditingController();
  TextEditingController createdDateTEC = new TextEditingController();

  void setData(StatusColumns statusColumns, Object val) {
    if (statusColumns == StatusColumns.heartRate) {
      statusModel.setHeartRate(val);
    } else if (statusColumns == StatusColumns.pulseRate) {
      statusModel.setPulseRate(val);
    } else if (statusColumns == StatusColumns.oxygen) {
      statusModel.setOxygen(val);
    } else if (statusColumns == StatusColumns.weight) {
      statusModel.setWeight(val);
    } else if (statusColumns == StatusColumns.sugar) {
      statusModel.setSugar(val);
    } else if (statusColumns == StatusColumns.urine) {
      statusModel.setUrine(val);
    } else if (statusColumns == StatusColumns.stool) {
      statusModel.setStool(val);
    } else if (statusColumns == StatusColumns.bloodPressure) {
      statusModel.setBloodPressure(val);
    } else if (statusColumns == StatusColumns.temperature) {
      statusModel.setTemperature(val);
    } else if (statusColumns == StatusColumns.incubatorTemperature) {
      statusModel.setIncubatorTemperature(val);
    }
  }

  String dateFormat() {
    String v = statusModel.getDateTime().day.toString();
    v = v + '/' + statusModel.getDateTime().month.toString();
    v = v + '/' + statusModel.getDateTime().year.toString();
    return v;
  }

  void getData() {
    heartRateTEC.text = statusModel.getHeartRate().toString();
    pulseRateTEC.text = statusModel.getPulseRate().toString();
    oxygenTEC.text = statusModel.getOxygen().toString();
    weightTEC.text = statusModel.getWeight().toString();
    sugarTEC.text = statusModel.getSugar().toString();
    urineTEC.text = statusModel.getUrine().toString();
    stoolTEC.text = statusModel.getStool().toString();
    bloodPressureTEC.text = statusModel.getBloodPressure().toString();
    temperatureTEC.text = statusModel.getTemperature().toString();
    incubatorTemperatureTEC.text = statusModel.getIncubatorTemperature().toString();
    createdDateTEC.text = dateFormat();
  }

  Widget columnTextField(String name, bool isNumber,
      StatusColumns statusColumns, TextEditingController columnTEC,
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
          setData(statusColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(statusColumns, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  void showDialogDatePicker() {
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

                  createdDateTEC.text = v;
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
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
                    statusModel.update();
                  } else {
                    statusModel.create();
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
                  'Hear Rate', true, StatusColumns.heartRate, heartRateTEC),
              columnTextField(
                  'Pulse Rate', true, StatusColumns.pulseRate, pulseRateTEC),
              columnTextField(
                  'Oxygen', true, StatusColumns.oxygen, oxygenTEC),
              columnTextField(
                  'Weight', true, StatusColumns.weight, weightTEC),
              columnTextField(
                  'Sugar', true, StatusColumns.sugar, sugarTEC),
              columnTextField(
                  'Urine', true, StatusColumns.urine, urineTEC),
              columnTextField(
                  'Blood Pressure', true, StatusColumns.bloodPressure, bloodPressureTEC),
              columnTextField(
                  'Temperature', true, StatusColumns.temperature, temperatureTEC),
              columnTextField(
                  'Incubator Temperature', true, StatusColumns.incubatorTemperature, incubatorTemperatureTEC),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
