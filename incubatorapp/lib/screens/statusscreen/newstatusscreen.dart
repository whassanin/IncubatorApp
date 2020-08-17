import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/widgets/form/statusformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewStatusScreen extends StatelessWidget {
  static const routeName = '/newstatusscreen';
  final Patient patient;
  NewStatusScreen({this.patient});

  @override
  Widget build(BuildContext context) {
    statusModel.createStatus();
    return ScopedModel(
      model: statusModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            StatusModel statusModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Status',style: TextStyle(color: Colors.white)),
            ),
            body: StatusFormWidget(
              patient: patient,
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
