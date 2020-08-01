import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PatientColumns {
  motherName,
  fatherName,
  gender,
  dateOfBirth,
  address,
  weight,
  SSN
}

class PatientFormWidget extends StatefulWidget {
  final bool isEdit;
  PatientFormWidget({this.isEdit});
  @override
  _PatientFormWidgetState createState() => _PatientFormWidgetState();
}

class _PatientFormWidgetState extends State<PatientFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  Widget columnTextField(
      String name, bool isNumber, PatientColumns patientColumns,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
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

  void showDialogSelectUserType() {
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
                  30,
                ),
              ),
            ),
            child: Text('Save'),
            onPressed: () {
              if (_formKey.currentState.validate()) {}
            },
          ),
        ),
      ),
    );

    Widget deleteButton = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        deleteButton = Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: Text('Delete'),
                onPressed: () {},
              ),
            ),
          ),
        );
      }
    }

    Widget rowButtons = Row(
      children: <Widget>[
        deleteButton,
        (widget.isEdit != null
            ? SizedBox(
                width: 10,
              )
            : Container()),
        saveButton
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: rowButtons,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            columnTextField('Social Security Number', true, PatientColumns.SSN),
            columnTextField('Mother Name', false, PatientColumns.motherName),
            columnTextField('Father Name', false, PatientColumns.fatherName),
            columnTextField('Weight Name', true, PatientColumns.weight),
            columnTextField('Address Name', false, PatientColumns.address),
            columnTextField('Date of Birth', false, PatientColumns.dateOfBirth,
                fun: showDialogSelectUserType),
            editButtons(),
          ],
        ),
      ),
    );
  }
}
