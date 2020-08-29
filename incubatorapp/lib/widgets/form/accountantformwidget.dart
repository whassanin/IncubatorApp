import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/accountantscreen/accountantprofilescreen.dart';

enum AccountantColumns {
  firstName,
  lastName,
  gender,
  dateOfBirth,
  email,
  password,
  confirmPassword,
  phone
}

class AccountantFormWidget extends StatefulWidget {
  final bool isEdit;
  AccountantFormWidget({
    this.isEdit,
  });
  @override
  _AccountantFormWidgetState createState() => _AccountantFormWidgetState();
}

class _AccountantFormWidgetState extends State<AccountantFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController firstNameTEC = new TextEditingController();
  TextEditingController lastNameTEC = new TextEditingController();
  TextEditingController genderTEC = new TextEditingController();
  TextEditingController dateOfBirthTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  TextEditingController confirmPasswordTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  void setData(AccountantColumns frontDeskColumns, Object val) {
    if (frontDeskColumns == AccountantColumns.firstName) {
      accountantModel.setFirstName(val);
    } else if (frontDeskColumns == AccountantColumns.lastName) {
      accountantModel.setLastName(val);
    } else if (frontDeskColumns == AccountantColumns.gender) {
      accountantModel.setGender(val);
    } else if (frontDeskColumns == AccountantColumns.dateOfBirth) {
      accountantModel.setDateOfBirth(DateTime.parse(val.toString()));
    } else if (frontDeskColumns == AccountantColumns.email) {
      userModel.setEmail(val);
    } else if (frontDeskColumns == AccountantColumns.password) {
      userModel.setPassword(val);
    } else if (frontDeskColumns == AccountantColumns.phone) {
      userModel.setPhone(val);
    }
  }

  String dateFormat() {
    String v = accountantModel.getDateOfBirth().day.toString();
    v = v + '/' + accountantModel.getDateOfBirth().month.toString();
    v = v + '/' + accountantModel.getDateOfBirth().year.toString();
    return v;
  }

  void getData() {
    firstNameTEC.text = accountantModel.getFirstName();
    lastNameTEC.text = accountantModel.getLastName();
    if (accountantModel.getGender()) {
      genderTEC.text = 'Male';
    } else {
      genderTEC.text = 'Female';
    }
    dateOfBirthTEC.text = dateFormat();
    emailTEC.text = userModel.getEmail();
    phoneTEC.text = userModel.getPhone();
  }

  Widget columnTextField(String name, bool isNumber, bool isObscure,
      AccountantColumns frontDeskColumns, TextEditingController columnTEC,
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
            if (frontDeskColumns == AccountantColumns.confirmPassword) {
              if (userModel.getPassword() != confirmPasswordTEC.text) {
                return 'Mismatch password';
              }
            }
          }
          return null;
        },
        onChanged: (v) {
          setData(frontDeskColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(frontDeskColumns, v);
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
                      setData(AccountantColumns.gender, true);
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Female'),
                    onTap: () {
                      genderTEC.text = 'Female';
                      setData(AccountantColumns.gender, false);
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
          accountantModel.update();
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
              accountantModel.setUserId(userModel.getId());

              accountantModel.create();

              userPermission.setPermission(UserType.accountant);

              await Future.delayed(Duration(seconds: 2));

              if (accountantModel.currentAccountant != null) {
                if (accountantModel.currentAccountant.userId != 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountantProfileScreen(),
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
                AccountantColumns.firstName,
                firstNameTEC,
              ),
              columnTextField(
                'Last Name',
                false,
                false,
                AccountantColumns.lastName,
                lastNameTEC,
              ),
              columnTextField(
                'Gender',
                false,
                false,
                AccountantColumns.gender,
                genderTEC,
                fun: showGenderPicker,
              ),
              columnTextField(
                'Date of Birth',
                false,
                false,
                AccountantColumns.dateOfBirth,
                dateOfBirthTEC,
                fun: showDialogDatePicker,
              ),
              columnTextField(
                'Phone',
                true,
                false,
                AccountantColumns.phone,
                phoneTEC,
              ),
              (widget.isEdit != null
                  ? (widget.isEdit == false
                  ? columnTextField(
                'Email',
                false,
                false,
                AccountantColumns.email,
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
                AccountantColumns.password,
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
                AccountantColumns.confirmPassword,
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
