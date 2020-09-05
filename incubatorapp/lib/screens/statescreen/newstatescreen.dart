import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/statetypemodel.dart';
import 'package:incubatorapp/widgets/form/stateformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewStateTypeScreen extends StatelessWidget {
  static const routeName = '/newstatescreen';

  NewStateTypeScreen();

  @override
  Widget build(BuildContext context) {
    stateTypeModel.createStateType();
    return ScopedModel<StateTypeModel>(
      model: stateTypeModel,
      child: ScopedModelDescendant<StateTypeModel>(
        builder: (BuildContext context, Widget childWidget,
            StateTypeModel stateModel) {
          return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.white,
                ),
                title: Text('New State Screen',style: TextStyle(color: Colors.white)),
                centerTitle: true,
              ),
              body: StateFormWidget(
                isEdit: false,
              )
          );
        },
      ),
    );
  }
}
