import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/views/incubator/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/widgets/List/incubatorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorScreen extends StatelessWidget {
  static const routeName = '/incubatorscreen';

  final bool isPatient;
  IncubatorScreen(this.isPatient);

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = ScopedModel<IncubatorModel>(
      model: incubatorModel,
      child: ScopedModelDescendant<IncubatorModel>(
        builder: (BuildContext context, Widget childWidget,
            IncubatorModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Incubator List',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewIncubatorScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: IncubatorListWidget(
              incubatorList: incubatorModel.incubatorList,
            ),
          );
        },
      ),
    );

    if (this.isPatient) {
      currentWidget = ScopedModel<PatientModel>(
        model: patientModel,
        child: ScopedModelDescendant<PatientModel>(
          builder: (BuildContext context, Widget childWidget,
              PatientModel patientModel) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.white,
                ),
                title: Text('Incubator List',
                    style: TextStyle(color: Colors.white)),
                centerTitle: true,
              ),
              body: IncubatorListWidget(
                incubatorList: incubatorModel.incubatorList,
              ),
            );
          },
        ),
      );
    }

    return currentWidget;
  }
}
