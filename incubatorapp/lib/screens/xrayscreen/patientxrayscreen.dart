import 'package:flutter/material.dart';
class PatientXRayScreen extends StatelessWidget {
  static const routeName = '/patientxrayscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XRay'),
      ),
      body: Center(
        child: Container(
          child: Text('Patient XRay List'),
        ),
      ),
    );
  }
}
