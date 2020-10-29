import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctorshiftmodel.dart';
import 'package:incubatorapp/widgets/form/doctorshiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewDoctorShiftScreen extends StatelessWidget {
  static const routeName = '/newdoctorshiftscreen';

  @override
  Widget build(BuildContext context) {
    doctorShiftModel.createDoctorShift();

    return ScopedModel<DoctorShiftModel>(
      model: doctorShiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            DoctorShiftModel doctorShiftModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New Doctor Shift',
                  style: TextStyle(color: Colors.white)),
            ),
            body: DoctorShiftFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
