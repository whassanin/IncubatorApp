import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/billmodel.dart';
import 'package:incubatorapp/widgets/List/billlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class BillScreen extends StatefulWidget {
  static const routeName = '/billscreen';

  BillScreen();

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    billModel.clearList();
  }

  @override
  Widget build(BuildContext context) {
    int l = patientModel.currentPatient.billList.length;
    if (l == 0) {
      billModel.readByPatientId(patientModel.currentPatient.userId);
    } else {
      billModel.setList(patientModel.currentPatient.billList);
    }

    return ScopedModel<BillModel>(
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
