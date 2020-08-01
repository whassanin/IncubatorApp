import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/form/patientformwidget.dart';
class PatientScreen extends StatelessWidget {
  static const routeName = '/patientscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Profile'),),
      body: PatientFormWidget(isEdit: true,),
    );
  }
}
