import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';

enum PatientColumns {
  motherName,
  fatherName,
  gender,
  dateOfBirth,
  address,
  weight,
  SSN,
  isOut,
  username,
  password,
  phone,
  incubator,
  condition
}

class PatientFormWidget extends StatefulWidget {
  final bool isEdit;
  final PatientModel patientModel;
  PatientFormWidget({this.isEdit, this.patientModel});
  @override
  _PatientFormWidgetState createState() => _PatientFormWidgetState();
}

class _PatientFormWidgetState extends State<PatientFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController motherNameTEC = new TextEditingController();
  TextEditingController fatherNameTEC = new TextEditingController();
  TextEditingController genderTEC = new TextEditingController();
  TextEditingController dateOfBirthTEC = new TextEditingController();
  TextEditingController addressTEC = new TextEditingController();
  TextEditingController weightTEC = new TextEditingController();
  TextEditingController ssnTEC = new TextEditingController();
  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  void setData(PatientColumns patientColumns, Object val) {
    if (patientColumns == PatientColumns.motherName) {
      widget.patientModel.setMotherName(val);
    } else if (patientColumns == PatientColumns.fatherName) {
      widget.patientModel.setFatherName(val);
    } else if (patientColumns == PatientColumns.gender) {
      widget.patientModel.setGender(val);
    } else if (patientColumns == PatientColumns.dateOfBirth) {
      widget.patientModel.setDateOfBirth(DateTime.parse(val.toString()));
    } else if (patientColumns == PatientColumns.address) {
      widget.patientModel.setAddress(val);
    } else if (patientColumns == PatientColumns.weight) {
      widget.patientModel.setWeight(double.parse(val.toString()));
    } else if (patientColumns == PatientColumns.SSN) {
      widget.patientModel.setSSN(val);
    } else if (patientColumns == PatientColumns.username) {
      widget.patientModel.setUserName(val);
    } else if (patientColumns == PatientColumns.password) {
      widget.patientModel.setPassword(val);
    }else if(patientColumns == PatientColumns.phone){
      widget.patientModel.setPhone(val);
    }
  }

  void getData() {
    ssnTEC.text = widget.patientModel.getSSN();
    motherNameTEC.text = widget.patientModel.getMotherName();
    fatherNameTEC.text = widget.patientModel.getFatherName();
    if (widget.patientModel.getGender()) {
      genderTEC.text = 'Male';
    } else {
      genderTEC.text = 'Female';
    }
    dateOfBirthTEC.text = widget.patientModel.getDateOfBirth().toString();
    weightTEC.text = widget.patientModel.getWeight().toString();
    addressTEC.text = widget.patientModel.getAddress();
    phoneTEC.text = widget.patientModel.getPhone();
  }


  Widget columnTextField(String name, bool isNumber,
      PatientColumns patientColumns, TextEditingController columnTEC,
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
          setData(patientColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(patientColumns, v);
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
                  dateOfBirthTEC.text = d.toString();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showGenderPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
                width: 150,
                height: 130,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Male'),
                      onTap: () {
                        genderTEC.text = 'Male';
                        print('Selected Male');
                        setData(PatientColumns.gender, true);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Female'),
                      onTap: () {
                        genderTEC.text = 'Female';
                        setData(PatientColumns.gender, false);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
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
                    widget.patientModel.update();
                  } else {
                    widget.patientModel.setCreatedDate(DateTime.now());
                    widget.patientModel.setConditionId(1);
                    widget.patientModel.setIncubatorId(1);
                    widget.patientModel.create();
                  }
                  widget.patientModel.updatePatientPhone();
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
                  'Social Security Number', true, PatientColumns.SSN, ssnTEC),
              columnTextField('Mother Name', false, PatientColumns.motherName,
                  motherNameTEC),
              columnTextField('Father Name', false, PatientColumns.fatherName,
                  fatherNameTEC),
              columnTextField(
                'Gender',
                false,
                PatientColumns.gender,
                genderTEC,
                fun: showGenderPicker,
              ),
              columnTextField('Date of Birth', false,
                  PatientColumns.dateOfBirth, dateOfBirthTEC,
                  fun: showDialogDatePicker),
              columnTextField('Weight', true, PatientColumns.weight, weightTEC),
              columnTextField(
                  'Address', false, PatientColumns.address, addressTEC),
              columnTextField('Phone', true, PatientColumns.phone, phoneTEC),
              (widget.isEdit != null
                  ? (widget.isEdit
                      ? Container()
                      : columnTextField('Username', false,
                          PatientColumns.username, usernameTEC))
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit
                      ? Container()
                      : columnTextField('Password', false,
                          PatientColumns.password, passwordTEC))
                  : Container()),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
