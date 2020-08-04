import 'package:flutter/material.dart';
class PatientMedicineDoctorScreen extends StatelessWidget {
  static const routeName = '/patientmedicinedoctorscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine'),
      ),
      body: Center(
        child: Container(
          child: Text('Patient Medicine Doctor List'),
        ),
      ),
    );
  }
}
