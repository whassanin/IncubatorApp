import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/form/patientformwidget.dart';

class NewPatientScreen extends StatelessWidget {
  static const routeName = '/newpatientscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Patient'),
      ),
      body: PatientFormWidget(
        isEdit: true,
      ),
    );
  }
}
