import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';

enum PatientColumns {
  motherName,
  fatherName,
  gender,
  dateOfBirth,
  address,
  weight,
  SSN,
  isOut,
  email,
  password,
  confirmPassword,
  phone,
  incubator,
  condition
}

class PatientFormWidget extends StatefulWidget {
  final bool isEdit;
  PatientFormWidget({
    this.isEdit,
  });
  @override
  _PatientFormWidgetState createState() => _PatientFormWidgetState();
}

class _PatientFormWidgetState extends State<PatientFormWidget> {
  final _formKey = new GlobalKey<FormState>();
  final GlobalKey _keyLoader = new GlobalKey();

  TextEditingController motherNameTEC = new TextEditingController();
  TextEditingController fatherNameTEC = new TextEditingController();
  TextEditingController genderTEC = new TextEditingController();
  TextEditingController dateOfBirthTEC = new TextEditingController();
  TextEditingController addressTEC = new TextEditingController();
  TextEditingController weightTEC = new TextEditingController();
  TextEditingController ssnTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  TextEditingController confirmPasswordTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  void setData(PatientColumns patientColumns, Object val) {
    if (patientColumns == PatientColumns.motherName) {
      patientModel.setMotherName(val);
    } else if (patientColumns == PatientColumns.fatherName) {
      patientModel.setFatherName(val);
    } else if (patientColumns == PatientColumns.gender) {
      patientModel.setGender(val);
    } else if (patientColumns == PatientColumns.dateOfBirth) {
      patientModel.setDateOfBirth(DateTime.parse(val.toString()));
    } else if (patientColumns == PatientColumns.address) {
      patientModel.setAddress(val);
    } else if (patientColumns == PatientColumns.weight) {
      patientModel.setWeight(double.parse(val.toString()));
    } else if (patientColumns == PatientColumns.SSN) {
      patientModel.setSSN(val);
    } else if (patientColumns == PatientColumns.email) {
      userModel.setEmail(val);
    } else if (patientColumns == PatientColumns.password) {
      userModel.setPassword(val);
    } else if (patientColumns == PatientColumns.phone) {
      userModel.setPhone(val);
    }
  }

  String dateFormat() {
    String v = patientModel.getDateOfBirth().day.toString();
    v = v + '/' + patientModel.getDateOfBirth().month.toString();
    v = v + '/' + patientModel.getDateOfBirth().year.toString();
    return v;
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: _keyLoader,
            backgroundColor: Colors.grey,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please Wait...',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void popPage() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  Future _onErrorDialog(BuildContext context, String title) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(title),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ),
        ],
      ),
    );
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      if (widget.isEdit != null) {
        if (widget.isEdit) {
          userModel.update();
          patientModel.update();
        } else {
          bool isValid = await userModel.checkEmail(emailTEC.text,false);

          await Future.delayed(Duration(seconds: 1));

          if (isValid == false) {
            showLoadingDialog(context);

            userModel.create();

            await Future.delayed(Duration(seconds: 2));

            userModel.readByEmailAndPassword();

            await Future.delayed(Duration(seconds: 5));

            if (userModel.currentUser != null) {
              patientModel.setUserId(userModel.getId());
              patientModel.setCreatedDate(DateTime.now());
              patientModel.setConditionId(1);
              patientModel.setIncubatorId(1);
              patientModel.setState('In');
              patientModel.create();

              userPermission.setPermission(UserType.patient);

              await Future.delayed(Duration(seconds: 2));

              if (patientModel.currentPatient != null) {
                if (patientModel.currentPatient.userId != 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientProfileScreen(
                        userPermission: userPermission,
                      ),
                    ),
                    ModalRoute.withName('/signinscreen'),
                  );
                } else {
                  _onErrorDialog(
                    context,
                    'Something went wrong. Please Try Again later',
                  );
                }
              } else {
                _onErrorDialog(
                  context,
                  'Something went wrong. Please Try Again later',
                );
              }
            }
          } else {
            _onErrorDialog(context, 'Email already exists');
          }
        }
      }
    }
  }

  void getData() {
    ssnTEC.text = patientModel.getSSN();
    motherNameTEC.text = patientModel.getMotherName();
    fatherNameTEC.text = patientModel.getFatherName();
    if (patientModel.getGender()) {
      genderTEC.text = 'Male';
    } else {
      genderTEC.text = 'Female';
    }
    dateOfBirthTEC.text = dateFormat();
    weightTEC.text = patientModel.getWeight().toString();
    addressTEC.text = patientModel.getAddress();
    phoneTEC.text = userModel.getPhone();
  }

  Widget columnTextField(String name, bool isNumber, bool isObscure,
      PatientColumns patientColumns, TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        obscureText: isObscure,
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
          if (v.isEmpty) {
            return 'Required';
          } else {
            if (patientColumns == PatientColumns.confirmPassword) {
              if (userModel.getPassword() != confirmPasswordTEC.text) {
                return 'Mismatch password';
              }
            }
          }
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
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () {
              save();
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
            child: Text('Delete', style: TextStyle(color: Colors.white)),
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
      }else {
        emailTEC.text = userModel.getEmail();
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
              columnTextField('Social Security Number', true, false,
                  PatientColumns.SSN, ssnTEC),
              columnTextField('Mother Name', false, false,
                  PatientColumns.motherName, motherNameTEC),
              columnTextField('Father Name', false, false,
                  PatientColumns.fatherName, fatherNameTEC),
              columnTextField(
                'Gender',
                false,
                false,
                PatientColumns.gender,
                genderTEC,
                fun: showGenderPicker,
              ),
              columnTextField('Date of Birth', false, false,
                  PatientColumns.dateOfBirth, dateOfBirthTEC,
                  fun: showDialogDatePicker),
              columnTextField(
                  'Weight', true, false, PatientColumns.weight, weightTEC),
              columnTextField(
                  'Address', false, false, PatientColumns.address, addressTEC),
              columnTextField(
                  'Phone', true, false, PatientColumns.phone, phoneTEC),
              (widget.isEdit != null
                  ? (widget.isEdit
                      ? Container()
                      : columnTextField('Email', false, false,
                          PatientColumns.email, emailTEC))
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit
                      ? Container()
                      : columnTextField('Password', false, true,
                          PatientColumns.password, passwordTEC))
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit
                      ? Container()
                      : columnTextField('Confirm Password', false, true,
                          PatientColumns.confirmPassword, confirmPasswordTEC))
                  : Container()),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
