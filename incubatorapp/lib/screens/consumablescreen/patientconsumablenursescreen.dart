import 'package:flutter/material.dart';
class PatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/patientconsumablenursescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumable'),
      ),
      body: Center(
        child: Container(
          child: Text('Patient Consumable List'),
        ),
      ),
    );
  }
}
