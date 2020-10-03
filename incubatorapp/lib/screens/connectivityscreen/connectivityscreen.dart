import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/screens/loginscreen/signinscreen.dart';

class ConnectivityScreen extends StatefulWidget {
  @override
  _ConnectivityScreenState createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
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

  void reload() async {
    showLoadingDialog(context);

    incubatorModel.readAll();
    conditionModel.readAll();
    shiftModel.readAll();
    laboratoryModel.readAll();
    xRayModel.readAll();
    medicineModel.readAll();
    consumableModel.readAll();
    extraModel.readAll();
    stateTypeModel.readAll();

    await Future.delayed(Duration(seconds: 5));

    if (incubatorModel.incubatorList.length > 0 &&
        conditionModel.conditionList.length > 0 &&
        shiftModel.shiftList.length > 0 &&
        laboratoryModel.laboratoryList.length > 0 &&
        xRayModel.xRayList.length > 0 &&
        medicineModel.medicineList.length > 0 &&
        consumableModel.consumableList.length > 0 &&
        extraModel.extraList.length > 0 &&
        stateTypeModel.stateTypeList.length > 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        ModalRoute.withName('/signinscreen'),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget iconConnect = Container(
      child: Icon(
        Icons.signal_wifi_off,
        size: 60,
      ),
    );

    Widget message1Text = Text(
      'No Internet Connection',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );

    Widget message2Text = Text(
      'Tap to refresh',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );

    Widget connectColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        iconConnect,
        message1Text,
        message2Text,
      ],
    );

    Widget connectGesture = GestureDetector(
      child: Center(
        child: connectColumn,
      ),
      onTap: () {
        reload();
      },
    );

    return Scaffold(
      body: connectGesture,
    );
  }
}
