import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nurseshiftmodel.dart';
import 'package:incubatorapp/widgets/form/nurseshiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewNurseShiftScreen extends StatelessWidget {
  static const routeName = '/newnurseshiftscreen';

  @override
  Widget build(BuildContext context) {
    nurseShiftModel.createNurseShift();

    return ScopedModel<NurseShiftModel>(
      model: nurseShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            NurseShiftModel nurseShiftModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New Nurse Shift',style: TextStyle(color: Colors.white)),
            ),
            body: NurseShiftFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
