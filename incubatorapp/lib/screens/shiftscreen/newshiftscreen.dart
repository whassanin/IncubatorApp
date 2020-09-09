import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/widgets/form/shiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    shiftModel.createShift();
    return ScopedModel<ShiftModel>(
      model: shiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ShiftModel shiftModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(
                'New Shift Screen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: ShiftFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
