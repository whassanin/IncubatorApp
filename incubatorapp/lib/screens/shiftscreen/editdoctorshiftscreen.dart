import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctorshiftmodel.dart';
import 'package:incubatorapp/widgets/form/doctorshiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditDoctorShiftScreen extends StatelessWidget {
  static const routeName = '/editdoctorshiftscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: doctorShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            DoctorShiftModel doctorShiftModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Doctor Shift'),
            ),
            body: DoctorShiftFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
