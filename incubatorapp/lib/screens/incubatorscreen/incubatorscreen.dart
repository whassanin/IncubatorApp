import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/screens/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/widgets/List/incubatorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorScreen extends StatelessWidget {
  final IncubatorModel incubatorModel = new IncubatorModel();
  @override
  Widget build(BuildContext context) {
    incubatorModel.readAll();

    return ScopedModel<IncubatorModel>(
      model: incubatorModel,
      child: ScopedModelDescendant<IncubatorModel>(
        builder: (BuildContext context, Widget childWidget,
            IncubatorModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Incubator List'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewIncubatorScreen(
                      incubatorModel: incubatorModel,
                    ),
                  ),
                );
              },
            ),
            body: IncubatorListWidget(
              incubatorList: incubatorModel.incubatorList,
            ),
          );
        },
      ),
    );
  }
}
