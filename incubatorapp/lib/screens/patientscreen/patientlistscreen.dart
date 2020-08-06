import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/List/patientlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientListScreen extends StatelessWidget {
  static const routeName = '/patientListscreen';

  final UserPermission userPermission;
  PatientListScreen({this.userPermission}){
    patientModel.filterByState('in');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, PatientModel patientModel) {

          return Scaffold(
            appBar: AppBar(
              title: Text('Patient List'),
            ),
            body:  PatientListWidget(
              patientList: patientModel.patientList,
              userPermission: userPermission,
            ),
          );
        },
      ),
    );
  }
}
