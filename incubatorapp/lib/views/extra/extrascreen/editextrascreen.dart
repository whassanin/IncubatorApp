import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/extramodel.dart';
import 'package:incubatorapp/widgets/form/extraformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditExtraScreen extends StatelessWidget {
  static const routeName = '/editextrascreen';
  EditExtraScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ExtraModel>(
      model: extraModel,
      child: ScopedModelDescendant<ExtraModel>(
        builder: (BuildContext context, Widget childWidget,
            ExtraModel extraModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit Extra Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: ExtraFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
