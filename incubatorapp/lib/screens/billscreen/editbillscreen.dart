import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/billmodel.dart';
import 'package:incubatorapp/widgets/form/billformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditBillScreen extends StatelessWidget {
  static const routeName = '/editbillscreen';
  EditBillScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BillModel>(
      model: billModel,
      child: ScopedModelDescendant<BillModel>(
        builder: (BuildContext context, Widget childWidget,
            BillModel billModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit Bill Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: BillFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
