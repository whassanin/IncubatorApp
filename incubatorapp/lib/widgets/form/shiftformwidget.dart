import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum ShiftColumns {
  name,
  startTime,
  isStartTimePM,
  endTime,
  isEndTimePM,
}

class ShiftFormWidget extends StatefulWidget {
  final bool isEdit;
  ShiftFormWidget({this.isEdit});
  @override
  _ShiftFormWidgetState createState() => _ShiftFormWidgetState();
}

class _ShiftFormWidgetState extends State<ShiftFormWidget> {
  List<String> optionHour = ['AM', 'PM'];
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController startTimeTEC = new TextEditingController();
  TextEditingController endTimeTEC = new TextEditingController();
  TextEditingController isStartTimePMTEC = new TextEditingController();
  TextEditingController isEndTimePMTEC = new TextEditingController();

  void setData(ShiftColumns shiftColumns, Object val) {
    if (shiftColumns == ShiftColumns.name) {
      shiftModel.setName(val);
    } else if (shiftColumns == ShiftColumns.startTime) {
      shiftModel.setStartTime(int.parse(val.toString()));
    } else if (shiftColumns == ShiftColumns.endTime) {
      shiftModel.setEndTime(int.parse(val.toString()));
    } else if (shiftColumns == ShiftColumns.isStartTimePM) {
      shiftModel.setIsStartTimePM(val);
    } else if (shiftColumns == ShiftColumns.isEndTimePM) {
      shiftModel.setIsEndTimePM(val);
    }
  }

  void getData() {
    startTimeTEC.text = shiftModel.getStartTime().toString();
    endTimeTEC.text = shiftModel.getEndTime().toString();
    if (shiftModel.getIsStartTimePM()) {
      isStartTimePMTEC.text = 'AM';
    } else {
      isStartTimePMTEC.text = 'PM';
    }

    if (shiftModel.getIsEndTimePM()) {
      isEndTimePMTEC.text = 'AM';
    } else {
      isEndTimePMTEC.text = 'PM';
    }
  }

  void showOptionHourPicker(ShiftColumns shiftColumns) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: ListView.builder(
                itemCount: optionHour.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title: Text(optionHour[i]),
                    onTap: () {
                      if (shiftColumns == ShiftColumns.isStartTimePM) {
                        if(optionHour[i] == 'AM'){
                          isStartTimePMTEC.text = 'AM';
                          setData(shiftColumns, false);
                        }else if(optionHour[i] == 'PM'){
                          isStartTimePMTEC.text = 'PM';
                          setData(shiftColumns, true);
                        }
                      } else if (shiftColumns == ShiftColumns.isEndTimePM) {
                        if(optionHour[i] == 'AM'){
                          isEndTimePMTEC.text = 'AM';
                          setData(shiftColumns, false);
                        }else if(optionHour[i] == 'PM'){
                          isEndTimePMTEC.text = 'PM';
                          setData(shiftColumns, true);
                        }
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget columnTextField(String name, bool isNumber, ShiftColumns shiftColumns,
      TextEditingController columnTEC, bool isReadOnly) {
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
        readOnly: isReadOnly,
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
          if (isReadOnly) {
            showOptionHourPicker(shiftColumns);
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
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Save',style: TextStyle(color: Colors.white)),
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
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Delete',style: TextStyle(color: Colors.white)),
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

  Widget shiftNameRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: columnTextField(
            'Name',
            false,
            ShiftColumns.name,
            nameTEC,
            false,
          ),
        ),
      ],
    );
  }

  Widget startTimeRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: columnTextField(
            'Start Time',
            true,
            ShiftColumns.startTime,
            startTimeTEC,
            false,
          ),
        ),
        Expanded(
          child: columnTextField(
            'AM or PM',
            true,
            ShiftColumns.isStartTimePM,
            isStartTimePMTEC,
            true,
          ),
        ),
      ],
    );
  }

  Widget endTimeRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: columnTextField(
            'End Time',
            true,
            ShiftColumns.endTime,
            endTimeTEC,
            false,
          ),
        ),
        Expanded(
          child: columnTextField(
            'AM or PM',
            true,
            ShiftColumns.isEndTimePM,
            isEndTimePMTEC,
            true,
          ),
        ),
      ],
    );
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
              shiftNameRow(),
              startTimeRow(),
              endTimeRow(),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
