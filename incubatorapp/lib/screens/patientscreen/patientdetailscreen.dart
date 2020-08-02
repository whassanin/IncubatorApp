import 'package:flutter/material.dart';
class PatientDetailScreen extends StatelessWidget {
  static const routeName = '/patientdetailscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Patient Detail'),),
        body: Center(child: Container(child: Text('Patient Detail'),))
    );
  }
}
