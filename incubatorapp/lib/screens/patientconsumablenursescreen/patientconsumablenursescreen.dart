import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/screens/patientconsumablenursescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/widgets/List/patientconsumablenurselistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/patientconsumablenursescreen';

  final Patient patient;
  final UserPermission userPermission;
  PatientConsumableNurseScreen({this.patient, this.userPermission});
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Consumable',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isNurse
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
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
