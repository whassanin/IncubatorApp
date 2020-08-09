import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/form/patientformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPatientScreen extends StatelessWidget {
  static const routeName = '/editpatientscreen';

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            PatientModel patientModel) {
          if(patientModel.currentPatient!=null){
            if(patientModel.currentPatient.id!=null){
              currentWidget = PatientFormWidget(
                patientModel: patientModel,
                isEdit: true,
              );
            }
          }

          return currentWidget;
        },
      ),
    );
  }
}
