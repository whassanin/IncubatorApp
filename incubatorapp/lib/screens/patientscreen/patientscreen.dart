import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';

class PatientScreen extends StatelessWidget {
  static const routeName = '/patientscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: PatientDetailRowWidget(),
      bottomNavigationBar: BottomNavigatorWidget(),
    );
  }
}
