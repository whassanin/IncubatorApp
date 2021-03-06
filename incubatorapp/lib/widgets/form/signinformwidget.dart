import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/views/accountant/accountantscreen/accountantprofilescreen.dart';
import 'package:incubatorapp/views/doctor/doctorscreen/doctorprofilescreen.dart';
import 'package:incubatorapp/views/login/loginscreen/forgetpasswordscreen.dart';
import 'package:incubatorapp/views/login/loginscreen/usertypescreen.dart';
import 'package:incubatorapp/views/nurse/nursescreen/nurseprofilescreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientprofilescreen.dart';

enum UserColumn { email, password }

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  void setData(UserColumn userColumn, Object val) {
    if (userColumn == UserColumn.email) {
      userModel.setEmail(val);
    } else if (userColumn == UserColumn.password) {
      userModel.setPassword(val);
    }
  }

  void getData() {
    emailTEC.text = userModel.getEmail();
    passwordTEC.text = userModel.getPassword();
  }

  void navigateToHomeScreen() {
    if (userPermission.isDoctor) {
      doctorModel.readById(userModel.currentUser.id.toString());
      doctorModel.setCurrentTab(0);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorProfileScreen(),
        ),
      );
    } else if (userPermission.isNurse) {
      nurseModel.readById(userModel.currentUser.id.toString());
      nurseModel.setCurrentTab(0);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NurseProfileScreen(),
        ),
      );
    } else if (userPermission.isPatient) {
      patientModel.readById(userModel.currentUser.id.toString());
      patientModel.setCurrentTab(0);
      Navigator.pushReplacementNamed(context, PatientProfileScreen.routeName);
    } else if (userPermission.isAccountant) {
      accountantModel.readById(userModel.currentUser.id.toString());
      accountantModel.setCurrentTab(0);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AccountantProfileScreen(),
        ),
      );
    } else {
      _onErrorDialog(context);
    }
  }

  void navigateToForgetPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgetPasswordScreen(),
      ),
    );
  }

  void signInByUsernameAndPassword() async {
    if (_formKey.currentState.validate()) {
      emailTEC.clear();
      passwordTEC.clear();

      showLoadingDialog(context);

      userModel.readByEmailAndPassword();

      await Future.delayed(Duration(seconds: 2));

      Navigator.pop(context);

      navigateToHomeScreen();
    }
  }

  void signInByHauweiId() async {
    userModel.setProvider(UserProvider.huawei);

    String v = await userModel.signIn();

    bool isCheck = await userModel.checkEmail(v, true);

    if (isCheck) {
      userModel.setPermission();
      navigateToHomeScreen();
    } else {
      signUp(userProvider: UserProvider.huawei, email: v);
    }
  }

  void signUp({UserProvider userProvider, String email}) {
    userModel.createUser();

    if (userProvider == null) {
      userModel.setProvider(UserProvider.other);
    } else {
      userModel.setProvider(userProvider);
    }

    if (email != null) {
      userModel.setEmail(email);
    }
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

  Future _onErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Invalid Email and Password'),
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
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
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
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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

  Widget subMessage(String title, double fontSize, Color color,
      {VoidCallback fun}) {
    return GestureDetector(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
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
      ),
      onTap: () {
        if (fun != null) {
          fun();
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getData();

    Decoration decoration = BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black,
      ),
    );

    Widget welcomeTitle = titleMessage('SIGN IN', 30, Colors.black);

    Widget orTitle = subMessage('OR', 14, Colors.grey);

    Widget forgetPasswordTitle = subMessage(
      'Forget Password?',
      14,
      Colors.grey,
      fun: navigateToForgetPasswordScreen,
    );

    Widget signInButton = buttonWidget(
      'Sign In',
      Colors.cyan,
      fun: signInByUsernameAndPassword,
    );

    Widget signByHuaweiIdButton = buttonWidget(
      'Sign by Hauwei ID',
      Colors.red,
      fun: signInByHauweiId,
    );

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
        columnTextField(UserColumn.email, 'Email', false, false, emailTEC),
        columnTextField(
            UserColumn.password, 'Password', false, true, passwordTEC),
        signInButton,
        forgetPasswordTitle,
        signUpButton
      ],
    );

    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: contentData,
        ),
      ),
    );
  }
}
