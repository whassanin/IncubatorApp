import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/views/incubator/incubatorwebpage/newincubatorwebpage.dart';
import 'package:incubatorapp/widgets/List/incubatorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorWebPage extends StatelessWidget {
  static const routeName = '/incubatorwebpage';

  IncubatorWebPage();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<IncubatorModel>(
      model: incubatorModel,
      child: ScopedModelDescendant<IncubatorModel>(
        builder: (BuildContext context, Widget childWidget,
            IncubatorModel incubatorModel) {
          Widget addIncubator = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      child: Text('New Incubator'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewIncubatorWebPage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );

          return Scaffold(
            body: Column(
              children: [
                addIncubator,
                Expanded(
                  child: IncubatorListWidget(
                    incubatorList: incubatorModel.incubatorList,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
