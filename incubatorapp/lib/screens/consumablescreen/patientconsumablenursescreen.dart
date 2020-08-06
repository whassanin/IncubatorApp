import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/screens/consumablescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/screens/user/userpermission.dart';
import 'package:incubatorapp/widgets/List/patientconsumablenurselistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class PatientConsumableNurseScreen extends StatelessWidget {
  static const routeName = '/patientconsumablenursescreen';

  final int patientId;
  final UserPermission userPermission;
  PatientConsumableNurseScreen({this.patientId,this.userPermission}){
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
            floatingActionButton: (userPermission.isNurse == true
                ? FloatingActionButton(
              child: IconButton(
                icon: Icon(Icons.add,color: Colors.white,),
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPatientConsumableNurseScreen()),
                  );
                },
              ),
            )
                : Container()),
            body: PatientConsumableNurseListWidget(
              patientConsumableNurseList: patientConsumableNurseModel.patientConsumableNurseList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
