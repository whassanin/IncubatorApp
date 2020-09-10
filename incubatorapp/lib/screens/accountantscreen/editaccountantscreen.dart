import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/accountantmodel.dart';
import 'package:incubatorapp/widgets/form/accountantformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditAccountantScreen extends StatelessWidget {
  static const routeName = '/editfrontdeskscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AccountantModel>(
      model: accountantModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            AccountantModel accountantModel) {
          return AccountantFormWidget(
            isEdit: true,
          );
        },
      ),
    );
  }
}
