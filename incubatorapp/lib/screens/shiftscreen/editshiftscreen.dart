import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/widgets/form/shiftformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: shiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ShiftModel shiftModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(
                'Edit Shift Screen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: ShiftFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
