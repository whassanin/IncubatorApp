import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/screens/consumablescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/widgets/List/patientconsumablenurselistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/patientconsumablenursescreen';

  final Patient patient;
  final UserPermission userPermission;
  PatientConsumableNurseScreen({this.patient, this.userPermission}) {
    patientConsumableNurseModel.createPatientConsumableNurse();
    patientConsumableNurseModel.setPatientId(patient.id);
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
              actions: <Widget>[
                (userPermission.isNurse
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewPatientConsumableNurseScreen(
                                    patient: patient,
                                userPermission: userPermission,
                              ),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientConsumableNurseListWidget(
              patientConsumableNurseList:
                  patientConsumableNurseModel.patientConsumableNurseList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
