import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/screens/doctorscreen/doctorprofilescreen.dart';
import 'package:incubatorapp/screens/loginscreen/usertypescreen.dart';
import 'package:incubatorapp/screens/nursescreen/nurseprofilescreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';

enum UserColumn { username, password }

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  final GlobalKey _keyLoader = new GlobalKey();

  void setData(UserColumn userColumn, Object val) {
    if (userColumn == UserColumn.username) {
      userModel.setUsername(val);
    } else if (userColumn == UserColumn.password) {
      userModel.setPassword(val);
    }
  }

  void getData() {
    usernameTEC.text = userModel.getUsername();
    passwordTEC.text = userModel.getPassword();
  }

  void navigateToHomeScreen() {
    if (userPermission.isDoctor) {
      doctorModel.readById(userModel.currentUser.id.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorProfileScreen(
            userPermission: userPermission,
          ),
        ),
      );
    } else if (userPermission.isNurse) {
      nurseModel.readById(userModel.currentUser.id.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NurseProfileScreen(
            userPermission: userPermission,
          ),
        ),
      );
    } else if (userPermission.isPatient) {
      patientModel.readById(userModel.currentUser.id.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PatientProfileScreen(
            userPermission: userPermission,
          ),
        ),
      );
    } else if (userPermission.isFrontDesk) {
    } else {
      _onErrorDialog(context);
    }
  }

  void signInByUsernameAndPassword() async {
    if (_formKey.currentState.validate()) {
      usernameTEC.clear();
      passwordTEC.clear();

      showLoadingDialog(context);

      userModel.readByUsernameAndPassword();

      popPage();

      await Future.delayed(Duration(seconds: 1));

      navigateToHomeScreen();
    }
  }

  void signInByHauweiId() {
    // TODO: Sign in by Hauwei Id
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserTypeScreen(),
      ),
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
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  Future _onErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Invalid username and password'),
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
      TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
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
          if(v.isEmpty){
            return 'Required';
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
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
        ));
  }

  Widget titleMessage(String title, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize, color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subMessage(String title, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize, color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();

    Decoration decoration = BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black,
      ),
    );

    Widget welcomeTitle = titleMessage('SIGN IN', 30, Colors.black);

    Widget orTitle = subMessage('OR', 14, Colors.grey);

    Widget forgetPasswordTitle =
        subMessage('Forget Password?', 14, Colors.grey);

    Widget signInButton = buttonWidget(
      'Sign In',
      Colors.cyan,
      fun: signInByUsernameAndPassword,
    );

    Widget signByHuaweiIdButton = buttonWidget('Sign by Hauwei ID', Colors.red);

    Widget signUpButton = buttonWidget(
      'Sign Up',
      Colors.black,
      fun: signUp,
    );

    Widget contentData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        welcomeTitle,
        signByHuaweiIdButton,
        orTitle,
        columnTextField(UserColumn.username, 'Username', false, usernameTEC),
        columnTextField(UserColumn.password, 'Password', false, passwordTEC),
        signInButton,
        forgetPasswordTitle,
        signUpButton
      ],
    );

    return Center(
        child: Form(
            key: _formKey, child: SingleChildScrollView(child: contentData)));
  }
}
