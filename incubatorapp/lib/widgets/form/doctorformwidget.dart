import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/doctorscreen/doctorprofilescreen.dart';

enum DoctorColumns {
  firstName,
  lastName,
  gender,
  dateOfBirth,
  email,
  password,
  confirmPassword,
  phone
}

class DoctorFormWidget extends StatefulWidget {
  final bool isEdit;
  DoctorFormWidget({
    this.isEdit,
  });
  @override
  _DoctorFormWidgetState createState() => _DoctorFormWidgetState();
}

class _DoctorFormWidgetState extends State<DoctorFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController firstNameTEC = new TextEditingController();
  TextEditingController lastNameTEC = new TextEditingController();
  TextEditingController genderTEC = new TextEditingController();
  TextEditingController dateOfBirthTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  TextEditingController confirmPasswordTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  void setData(DoctorColumns doctorColumns, Object val) {
    if (doctorColumns == DoctorColumns.firstName) {
      doctorModel.setFirstName(val);
    } else if (doctorColumns == DoctorColumns.lastName) {
      doctorModel.setLastName(val);
    } else if (doctorColumns == DoctorColumns.gender) {
      doctorModel.setGender(val);
    } else if (doctorColumns == DoctorColumns.dateOfBirth) {
      doctorModel.setDateOfBirth(DateTime.parse(val.toString()));
    } else if (doctorColumns == DoctorColumns.email) {
      userModel.setEmail(val);
    } else if (doctorColumns == DoctorColumns.password) {
      userModel.setPassword(val);
    } else if (doctorColumns == DoctorColumns.phone) {
      userModel.setPhone(val);
    }
  }

  String dateFormat() {
    String v = doctorModel.getDateOfBirth().day.toString();
    v = v + '/' + doctorModel.getDateOfBirth().month.toString();
    v = v + '/' + doctorModel.getDateOfBirth().year.toString();
    return v;
  }

  void getData() {
    firstNameTEC.text = doctorModel.getFirstName();
    lastNameTEC.text = doctorModel.getLastName();
    if (doctorModel.getGender()) {
      genderTEC.text = 'Male';
    } else {
      genderTEC.text = 'Female';
    }
    dateOfBirthTEC.text = dateFormat();
    emailTEC.text = userModel.getEmail();
    phoneTEC.text = userModel.getPhone();
  }

  Widget columnTextField(String name, bool isNumber, bool isObscure,
      DoctorColumns doctorColumns, TextEditingController columnTEC,
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
            if (doctorColumns == DoctorColumns.password){
              String m = userModel.validatePassword(v);
              if(m.isEmpty){
                return null;
              }else {
                return m;
              }
            }
            else if (doctorColumns == DoctorColumns.confirmPassword) {
              if (userModel.getPassword() != confirmPasswordTEC.text) {
                return 'Mismatch password';
              }
            }
          }
          return null;
        },
        onChanged: (v) {
          setData(doctorColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(doctorColumns, v);
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
                  setData(DoctorColumns.dateOfBirth,d);
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
                      setData(DoctorColumns.gender, true);
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Female'),
                    onTap: () {
                      genderTEC.text = 'Female';
                      setData(DoctorColumns.gender, false);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
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
          doctorModel.update();
        } else {
          bool isValid = await userModel.checkEmail(emailTEC.text, false);

          await Future.delayed(Duration(seconds: 1));

          if (isValid == false) {
            showLoadingDialog(context);

            userModel.create();

            await Future.delayed(Duration(seconds: 2));

            userModel.readByEmailAndPassword();

            await Future.delayed(Duration(seconds: 3));

            if (userModel.currentUser != null) {
              doctorModel.setUserId(userModel.getId());

              doctorModel.create();

              userPermission.setPermission(UserType.doctor);

              await Future.delayed(Duration(seconds: 2));

              if (doctorModel.currentDoctor != null) {
                if (doctorModel.currentDoctor.userId != 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorProfileScreen(),
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
            _onErrorDialog(context, 'Email already taken');
          }
        }
      }
    }
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
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
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
      } else {
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
              columnTextField(
                'First Name',
                false,
                false,
                DoctorColumns.firstName,
                firstNameTEC,
              ),
              columnTextField(
                'Last Name',
                false,
                false,
                DoctorColumns.lastName,
                lastNameTEC,
              ),
              columnTextField(
                'Gender',
                false,
                false,
                DoctorColumns.gender,
                genderTEC,
                fun: showGenderPicker,
              ),
              columnTextField(
                'Date of Birth',
                false,
                false,
                DoctorColumns.dateOfBirth,
                dateOfBirthTEC,
                fun: showDialogDatePicker,
              ),
              columnTextField(
                'Phone',
                true,
                false,
                DoctorColumns.phone,
                phoneTEC,
              ),
              (widget.isEdit != null
                  ? (widget.isEdit == false
                      ? columnTextField(
                          'Email',
                          false,
                          false,
                          DoctorColumns.email,
                          emailTEC,
                        )
                      : Container())
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit == false
                      ? columnTextField(
                          'Password',
                          false,
                          true,
                          DoctorColumns.password,
                          passwordTEC,
                        )
                      : Container())
                  : Container()),
              (widget.isEdit != null
                  ? (widget.isEdit == false
                      ? columnTextField(
                          'Confirm Password',
                          false,
                          true,
                          DoctorColumns.confirmPassword,
                          confirmPasswordTEC,
                        )
                      : Container())
                  : Container()),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
