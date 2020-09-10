import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/widgets/List/consumablelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientConsumableNurseScreen extends StatefulWidget {
  static const routeName = '/newpatientconsumablenursescreen';

  final Patient patient;
  NewPatientConsumableNurseScreen({this.patient,});

  @override
  _NewPatientConsumableNurseScreenState createState() => _NewPatientConsumableNurseScreenState();
}

class _NewPatientConsumableNurseScreenState extends State<NewPatientConsumableNurseScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    consumableModel.setSearchName('');
    consumableModel.readAll();
    patientConsumableNurseModel.readByPatientId(widget.patient.userId);
  }

  @override
  Widget build(BuildContext context) {



    return ScopedModel<PatientConsumableNurseModel>(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return ScopedModel<ConsumableModel>(
            model: consumableModel,
            child: ScopedModelDescendant(
              builder: (BuildContext context, Widget child,
                  ConsumableModel consumableModel){
                return Scaffold(
                  appBar: AppBar(
                    leading: BackButton(
                      color: Colors.white,
                    ),
                    title: Text('Add Consumable to Patient',style: TextStyle(color: Colors.white)),
                  ),
                  body: ConsumableListWidget(
                    patient: widget.patient,
                    consumableList: consumableModel.consumableList,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
