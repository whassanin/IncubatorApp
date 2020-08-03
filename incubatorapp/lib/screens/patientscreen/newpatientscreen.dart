import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/form/patientformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientScreen extends StatelessWidget {
  static const routeName = '/newpatientscreen';

  @override
  Widget build(BuildContext context) {
    patientModel.createPatient();
    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(builder: (BuildContext context, Widget childWidget,
          PatientModel patientModel){
        return Scaffold(
          appBar: AppBar(
            title: Text('Register Patient'),
          ),
          body: PatientFormWidget(
            patientModel: patientModel,
            isEdit: false,
          ),
        );
      },),
    );
  }
}
