import 'package:flutter/material.dart';
class PatientScreen extends StatelessWidget {
  static const routeName = '/patientscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Profile'),),
      body: Container(child: Text('Patient Screen'),)
    );
  }
}
