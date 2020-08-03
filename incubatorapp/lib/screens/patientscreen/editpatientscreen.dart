import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/form/patientformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditPatientScreen extends StatelessWidget {

  EditPatientScreen(){
    patientModel.readById('2');
  }

  @override
  Widget build(BuildContext context) {

    Widget progressIndicator = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(builder: (BuildContext context, Widget childWidget,
          PatientModel patientModel){
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Patient Profile'),
          ),
          body: (patientModel.currentPatient!=null?PatientFormWidget(
            patientModel: patientModel,
            isEdit: true,
          ):progressIndicator)
        );
      },),
    );
  }
}
