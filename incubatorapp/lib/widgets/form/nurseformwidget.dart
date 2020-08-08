import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum NurseColumns {
  firstName,
  lastName,
  gender,
  dateOfBirth,
  username,
  password,
}

class NurseFormWidget extends StatefulWidget {
  final bool isEdit;
  NurseFormWidget({
    this.isEdit,
  });
  @override
  _NurseFormWidgetState createState() => _NurseFormWidgetState();
}

class _NurseFormWidgetState extends State<NurseFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController firstNameTEC = new TextEditingController();
  TextEditingController lastNameTEC = new TextEditingController();
  TextEditingController genderTEC = new TextEditingController();
  TextEditingController dateOfBirthTEC = new TextEditingController();
  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  void setData(NurseColumns nurseColumns, Object val) {
    if (nurseColumns == NurseColumns.firstName) {
      nurseModel.setFirstName(val);
    } else if (nurseColumns == NurseColumns.lastName) {
      nurseModel.setLastName(val);
    } else if (nurseColumns == NurseColumns.gender) {
      nurseModel.setGender(val);
    } else if (nurseColumns == NurseColumns.dateOfBirth) {
      nurseModel.setDateOfBirth(DateTime.parse(val.toString()));
    } else if (nurseColumns == NurseColumns.username) {
      nurseModel.setUserName(val);
    } else if (nurseColumns == NurseColumns.password) {
      nurseModel.setPassword(val);
    }
  }

  String dateFormat() {
    String v = nurseModel.getDateOfBirth().day.toString();
    v = v + '/' + nurseModel.getDateOfBirth().month.toString();
    v = v + '/' + nurseModel.getDateOfBirth().year.toString();
    return v;
  }

  void getData() {
    firstNameTEC.text = nurseModel.getFirstName();
    lastNameTEC.text = nurseModel.getLastName();
    if (nurseModel.getGender()) {
      genderTEC.text = 'Male';
    } else {
      genderTEC.text = 'Female';
    }
    dateOfBirthTEC.text = dateFormat();
  }

  Widget columnTextField(String name, bool isNumber,
      NurseColumns nurseColumns, TextEditingController columnTEC,
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
          setData(nurseColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(nurseColumns, v);
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

                  dateOfBirthTEC.text = v;
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
                        setData(NurseColumns.gender, true);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Female'),
                      onTap: () {
                        genderTEC.text = 'Female';
                        setData(NurseColumns.gender, false);
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
                    nurseModel.update();
                  } else {
                    nurseModel.setCreatedDate(DateTime.now());
                    nurseModel.create();
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
                  'First Name', false, NurseColumns.firstName, firstNameTEC),
              columnTextField(
                  'Last Name', false, NurseColumns.lastName, lastNameTEC),
              columnTextField(
                'Gender',
                false,
                NurseColumns.gender,
                genderTEC,
                fun: showGenderPicker,
              ),
              columnTextField('Date of Birth', false, NurseColumns.dateOfBirth,
                  dateOfBirthTEC,
                  fun: showDialogDatePicker),
              (widget.isEdit != null
                  ? (widget.isEdit
                  ? Container()
                  : columnTextField('Username', false,
                  NurseColumns.username, usernameTEC))
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit
                  ? Container()
                  : columnTextField('Password', false,
                  NurseColumns.password, passwordTEC))
                  : Container()),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
