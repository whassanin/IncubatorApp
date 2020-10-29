import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/views/consumable/consumablescreen/newconsumablescreen.dart';
import 'package:incubatorapp/widgets/List/consumablelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class ConsumableScreen extends StatelessWidget {
  static const routeName = '/consumablescreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ConsumableModel>(
      model: consumableModel,
      child: ScopedModelDescendant<ConsumableModel>(
        builder: (BuildContext context, Widget childWidget,
            ConsumableModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title:
              Text('Consumable List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewConsumableScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: ConsumableListWidget(
              consumableList: consumableModel.consumableList,
            ),
          );
        },
      ),
    );
  }
}
