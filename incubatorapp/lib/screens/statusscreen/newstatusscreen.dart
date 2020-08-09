import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/widgets/form/doctorformwidget.dart';
import 'package:incubatorapp/widgets/form/statusformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewStatusScreen extends StatelessWidget {
  static const routeName = '/newstatusscreen';

  @override
  Widget build(BuildContext context) {
    doctorModel.createDoctor();
    return ScopedModel(
      model: statusModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            StatusModel statusModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Status'),
            ),
            body: StatusFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
