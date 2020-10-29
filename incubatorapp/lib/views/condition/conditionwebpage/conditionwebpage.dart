import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/conditionmodel.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/views/condition/conditionwebpage/newconditionwebpage.dart';
import 'package:incubatorapp/widgets/List/conditionlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class ConditionWebPage extends StatelessWidget {
  static const routeName = '/conditionwebpage';

  ConditionWebPage();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ConditionModel>(
      model: conditionModel,
      child: ScopedModelDescendant<ConditionModel>(
        builder: (BuildContext context, Widget childWidget,
            ConditionModel incubatorModel) {

          Widget addCondition = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      child: Text('New Condition'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewConditionWebPage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );

          return Scaffold(
            body: Column(
              children: [
                addCondition,
                ConditionListWidget(
                  conditionList: conditionModel.conditionList,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
