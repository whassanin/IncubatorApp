import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/widgets/form/shiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class NewShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    shiftModel.createShift();
    return ScopedModel(
      model: shiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ShiftModel shiftModel){
          return Scaffold(
            appBar: AppBar(title: Text('New Shift Screen'),),
            body: ShiftFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
