import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';

class SuccessfulMessageScreen extends StatelessWidget {
  static const routeName = '/successfulmessagescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                size: 150,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Payment Successful!',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: Center(child: Text('Continue')),
                ),
                onTap: () {
                  Navigator.popUntil(context,
                      ModalRoute.withName(PatientProfileScreen.routeName));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
