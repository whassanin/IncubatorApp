import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/conditionmodel.dart';
import 'package:incubatorapp/widgets/form/conditionformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewConditionWebPage extends StatelessWidget {
  static const routeName = '/newconditionwebpage';

  NewConditionWebPage();

  @override
  Widget build(BuildContext context) {
    conditionModel.createCondition();
    return ScopedModel<ConditionModel>(
      model: conditionModel,
      child: ScopedModelDescendant<ConditionModel>(
        builder: (BuildContext context, Widget childWidget,
            ConditionModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New Condition Web Page',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: ConditionFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
