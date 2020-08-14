import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctorshiftmodel.dart';
import 'package:incubatorapp/widgets/List/doctorshiftlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class DoctorShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    doctorShiftModel.readByDoctorId(doctorModel.currentDoctor.userId);

    return ScopedModel(
      model: doctorShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context,Widget child,DoctorShiftModel doctorShiftModel){
          return DoctorShiftListWidget(doctorShiftList: doctorShiftModel.doctorShiftList,);
        },
      ),
    );

  }
}
