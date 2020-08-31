import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/widgets/form/consumableformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewConsumableScreen extends StatelessWidget {
  static const routeName = '/newconsumablescreen';

  NewConsumableScreen();

  @override
  Widget build(BuildContext context) {
    consumableModel.createConsumable();
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
              title: Text('New Consumable Screen',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: ConsumableFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
