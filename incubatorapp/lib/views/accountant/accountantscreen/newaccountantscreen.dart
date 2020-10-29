import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/accountantmodel.dart';
import 'package:incubatorapp/widgets/form/accountantformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewAccountantScreen extends StatelessWidget {
  static const routeName = '/newfrontdeskscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AccountantModel>(
      model: accountantModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            AccountantModel accountantModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Register Accountant',style: TextStyle(color: Colors.white)),
            ),
            body: AccountantFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
