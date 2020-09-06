import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/billmodel.dart';
import 'package:incubatorapp/widgets/List/billlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class BillScreen extends StatelessWidget {
  static const routeName = '/billscreen';

  BillScreen();

  @override
  Widget build(BuildContext context) {

    return ScopedModel(
      model: billModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, BillModel billModel) {
          Widget currentWidget = BillListWidget(
            billList: billModel.billList,
          );

          if (userPermission.isAccountant) {
            currentWidget = Scaffold(
              appBar: AppBar(
                title: Text(
                  'Patient Bills',
                  style: TextStyle(color: Colors.white),
                ),
                leading: BackButton(
                  color: Colors.white,
                ),
              ),
              body: currentWidget,
            );
          }

          return currentWidget;
        },
      ),
    );
  }
}
