import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/widgets/List/consumablelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/newpatientconsumablenursescreen';

  final Patient patient;
  final UserPermission userPermission;
  NewPatientConsumableNurseScreen({this.patient,this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Consumable to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: ConsumableListWidget(
              patient: patient,
              consumableList: consumableModel.consumableList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
