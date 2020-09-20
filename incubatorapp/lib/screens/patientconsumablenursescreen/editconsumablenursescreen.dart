import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/widgets/form/patientconsumablenurseformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/editpatientconsumablenursescreen';

  final Consumable consumable;
  final PatientConsumableNurse patientConsumableNurse;
  EditPatientConsumableNurseScreen({this.patientConsumableNurse, this.consumable});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientConsumableNurseModel>(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Add Consumable to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: PatientConsumableNurseFormWidget(
              patientConsumableNurse: patientConsumableNurse,
              consumable: consumable,
            ),
          );
        },
      ),
    );
  }
}
