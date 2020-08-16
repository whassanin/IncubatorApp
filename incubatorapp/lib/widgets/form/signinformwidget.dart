import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  Widget columnTextField(
      String name, bool isNumber, TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 15),
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

  Widget buttonWidget (String title, Color color){
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
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

  Widget titleMessage (String title,double fontSize,Color color){
    return Padding(
      padding: const EdgeInsets.only(top: 50,bottom: 50,left: 30,right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize,color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subMessage (String title,double fontSize,Color color){
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize,color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.black,
      ),
    );

    Widget welcomeTitle =titleMessage('SIGN IN',30,Colors.black);

    Widget orTitle = subMessage('OR',14,Colors.grey);

    Widget forgetPasswordTitle = subMessage('Forget Password?',14,Colors.grey);

    Widget signInButton = buttonWidget('Sign In',Colors.cyan);

    Widget signByHuaweiIdButton = buttonWidget('Sign by Hauwei ID',Colors.red);

    Widget signUpButton = buttonWidget('Sign Up',Colors.black);

    Widget contentData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        welcomeTitle,
        signByHuaweiIdButton,
        orTitle,
        columnTextField('Username', false, usernameTEC),
        columnTextField('Password', false, passwordTEC),
        signInButton,
        forgetPasswordTitle,
        signUpButton
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 60,bottom: 60),
      child: SingleChildScrollView(child: contentData),
    );
  }
}
