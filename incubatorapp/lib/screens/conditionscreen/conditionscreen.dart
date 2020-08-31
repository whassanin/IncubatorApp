import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/conditionmodel.dart';
import 'package:incubatorapp/screens/conditionscreen/newconditionscreen.dart';
import 'package:incubatorapp/widgets/List/conditionlist.dart';
import 'package:scoped_model/scoped_model.dart';

class ConditionScreen extends StatelessWidget {
  static const routeName = '/conditionscreen';

  @override
  Widget build(BuildContext context) {
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
              title:
              Text('Condition List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewConditionScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: ConditionListWidget(
              conditionList: conditionModel.conditionList,
            ),
          );
        },
      ),
    );
  }
}
