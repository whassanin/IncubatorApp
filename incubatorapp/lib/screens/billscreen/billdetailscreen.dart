import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/billsmodel.dart';
import 'package:incubatorapp/widgets/row/billdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class BillDetailScreen extends StatelessWidget {
  static const routeName = '/billdetailscreen';

  BillDetailScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: billModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, BillModel billModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Bill Detail',style: TextStyle(color: Colors.white)),
            ),
            body: BillDetailRowWidget(bill: billModel.currentBill,)
          );
        },
      ),
    );
  }
}
