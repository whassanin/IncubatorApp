import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/billsmodel.dart';
import 'package:incubatorapp/widgets/List/billlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class BillScreen extends StatelessWidget {

  final int patientId;
  BillScreen({this.patientId}) {
    billModel.createBill();
    billModel.setPatientId(patientId);
    billModel.readByPatientId();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: billModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, BillModel billModel) {

          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if(billModel.billList!=null){
            currentWidget = BillListWidget(
              billList: billModel.billList,
            );
          }

          return currentWidget;
        },
      ),
    );
  }
}
