import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/extramodel.dart';
import 'package:incubatorapp/widgets/form/extraformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewExtraScreen extends StatelessWidget {
  static const routeName = '/newextrascreen';

  NewExtraScreen();

  @override
  Widget build(BuildContext context) {
    extraModel.createExtra();
    return ScopedModel<ExtraModel>(
      model: extraModel,
      child: ScopedModelDescendant<ExtraModel>(
        builder: (BuildContext context, Widget childWidget,
            ExtraModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New Extra Screen',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: ExtraFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
