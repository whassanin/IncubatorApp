import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/billsmodel.dart';
import 'package:incubatorapp/widgets/List/billlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class BillScreen extends StatelessWidget {
  static const routeName = '/billscreen';

  final Patient patient;
  BillScreen({this.patient});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: billModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, BillModel billModel) {
          return BillListWidget(
            billList: billModel.billList,
          );
        },
      ),
    );
  }
}
