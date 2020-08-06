import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/widgets/List/consumablelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class NewPatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/newpatientconsumablenursescreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, PatientConsumableNurseModel patientConsumableNurseModel){
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Analysis to Patient'),
            ),
            body: ConsumableListWidget(consumableList: consumableModel.consumableList,isPatientConsumableNurse: true,),
          );
        },
      ),
    );
  }
}
