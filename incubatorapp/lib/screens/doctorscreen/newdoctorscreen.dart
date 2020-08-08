import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/widgets/form/doctorformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewDoctorScreen extends StatelessWidget {
  static const routeName = '/newdoctorscreen';

  @override
  Widget build(BuildContext context) {
    doctorModel.createDoctor();
    return ScopedModel(
      model: doctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            DoctorModel doctorModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Register Doctor'),
            ),
            body: DoctorFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
