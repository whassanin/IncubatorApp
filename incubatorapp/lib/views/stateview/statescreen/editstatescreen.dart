import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/statetypemodel.dart';
import 'package:incubatorapp/widgets/form/stateformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditStateTypeScreen extends StatelessWidget {
  static const routeName = '/editstatescreen';
  EditStateTypeScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StateTypeModel>(
      model: stateTypeModel,
      child: ScopedModelDescendant<StateTypeModel>(
        builder: (BuildContext context, Widget childWidget,
            StateTypeModel stateTypeModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit State Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: StateFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
