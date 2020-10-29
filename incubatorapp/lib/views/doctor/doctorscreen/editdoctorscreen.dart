import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/widgets/form/doctorformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditDoctorScreen extends StatelessWidget {
  static const routeName = '/editdoctorscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DoctorModel>(
      model: doctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            DoctorModel doctorModel) {
          return DoctorFormWidget(
            isEdit: true,
          );
        },
      ),
    );
  }
}
