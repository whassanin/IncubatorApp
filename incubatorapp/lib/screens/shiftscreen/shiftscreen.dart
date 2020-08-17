import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/widgets/List/shiftlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:incubatorapp/main.dart';

class ShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: shiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context,Widget child,ShiftModel shiftModel){
          return Scaffold(
            appBar: AppBar(
              title: Text('Shift Screen',style: TextStyle(color: Colors.white)),
            ),
            body: ShiftListWidget(
              shiftList: shiftModel.shiftList,
            ),
          );
        },
      ),
    );
  }
}
