import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/widgets/form/incubatorformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewIncubatorScreen extends StatelessWidget {
  static const routeName = '/newincubatorscreen';
  final IncubatorModel incubatorModel;

  NewIncubatorScreen({this.incubatorModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<IncubatorModel>(
      model: incubatorModel,
      child: ScopedModelDescendant<IncubatorModel>(
        builder: (BuildContext context, Widget childWidget,
            IncubatorModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('New Incubator Screen'),
              centerTitle: true,
            ),
            body: IncubatorFormWidget(
              incubatorModel: incubatorModel,
            ),
          );
        },
      ),
    );
  }
}
