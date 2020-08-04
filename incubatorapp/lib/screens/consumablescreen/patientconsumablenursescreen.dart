import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/widgets/List/patientconsumablenurselistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class PatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/patientconsumablenursescreen';

  final int patientId;
  PatientConsumableNurseScreen({this.patientId}){
    patientConsumableNurseModel.createPatientConsumableNurse();
    patientConsumableNurseModel.setPatientId(patientId);
    patientConsumableNurseModel.readByPatientId();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Consumable'),
            ),
            body: PatientConsumableNurseListWidget(
              patientConsumableNurseList: patientConsumableNurseModel.patientConsumableNurseList,
            ),
          );
        },
      ),
    );
  }
}
