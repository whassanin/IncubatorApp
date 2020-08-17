import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nurseshiftmodel.dart';
import 'package:incubatorapp/widgets/form/nurseshiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditNurseShiftScreen extends StatelessWidget {
  static const routeName = '/editnurseshiftscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: nurseShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            NurseShiftModel nurseShiftModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Nurse Shift',style: TextStyle(color: Colors.white)),
            ),
            body: NurseShiftFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
