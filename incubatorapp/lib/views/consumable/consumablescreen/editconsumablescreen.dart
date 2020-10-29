import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/widgets/form/consumableformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditConsumableScreen extends StatelessWidget {
  static const routeName = '/editconsumablescreen';
  EditConsumableScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ConsumableModel>(
      model: consumableModel,
      child: ScopedModelDescendant<ConsumableModel>(
        builder: (BuildContext context, Widget childWidget,
            ConsumableModel consumableModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit Consumable Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: ConsumableFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
