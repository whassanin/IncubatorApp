import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

class ForgetPasswordFormWidget extends StatefulWidget {
  @override
  _ForgetPasswordFormWidgetState createState() =>
      _ForgetPasswordFormWidgetState();
}

enum UserColumn { email, password, confirmPassword }

class _ForgetPasswordFormWidgetState extends State<ForgetPasswordFormWidget> {
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  TextEditingController confirmPasswordTEC = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  void setData(UserColumn userColumn, Object val) {
    if (userColumn == UserColumn.email) {
      userModel.setEmail(val);
    } else if (userColumn == UserColumn.password) {
      userModel.setPassword(val);
    }
  }

  void resetPassword() async {
    if (_formKey.currentState.validate()) {
      bool isValid = await userModel.checkEmail(emailTEC.text,true);

      await Future.delayed(Duration(seconds: 2));

      if (isValid == true) {
        isValid = await userModel.update();

        await Future.delayed(Duration(seconds: 1));
        if (isValid == true) {
          Navigator.pop(context);
        } else {
          _onErrorDialog(context, 'Can not update');
        }
      } else {
        _onErrorDialog(context, 'User does not exist');
      }
    }
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

  Widget columnTextField(UserColumn userColumn, String name, bool isNumber,
      bool isObscure, TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
            if (userColumn == UserColumn.email) {
              String m = userModel.validateEmail(v);
              if (m.isEmpty) {
                return null;
              } else {
                return m;
              }
            } else if (userColumn == UserColumn.password) {
              String m = userModel.validatePassword(v);
              if (m.isEmpty) {
                return null;
              } else {
                return m;
              }
            }
            else if (userColumn == UserColumn.confirmPassword) {
              if (userModel.getPassword() != confirmPasswordTEC.text) {
                return 'Mismatch password';
              }
            }
          }
          return null;
        },
        onChanged: (v) {
          setData(userColumn, v);
        },
        onFieldSubmitted: (v) {
          setData(userColumn, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  Widget buttonWidget(String title, Color color, {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  if (fun != null) {
                    fun();
                  }
                },
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget userNameWidget =
        columnTextField(UserColumn.email, 'Email', false, false, emailTEC);
    Widget passwordWidget = columnTextField(
        UserColumn.password, 'New Password', false, true, passwordTEC);
    Widget confirmPasswordWidget = columnTextField(UserColumn.confirmPassword,
        'Confirm Password', false, true, confirmPasswordTEC);
    Widget updateButton =
        buttonWidget('Reset password', Colors.cyan, fun: resetPassword);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            userNameWidget,
            passwordWidget,
            confirmPasswordWidget,
            updateButton
          ],
        ),
      ),
    );
  }
}
