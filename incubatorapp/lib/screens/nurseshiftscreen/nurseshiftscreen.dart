import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nurseshiftmodel.dart';
import 'package:incubatorapp/widgets/List/nurseshiftlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class NurseShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    nurseShiftModel.readByNurseId(nurseModel.currentNurse.userId);

    return ScopedModel(
      model: nurseShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context,Widget child,NurseShiftModel nurseShiftModel){
          return NurseShiftListWidget(nurseShiftList: nurseShiftModel.nurseShiftList,);
        },
      ),
    );

  }
}
