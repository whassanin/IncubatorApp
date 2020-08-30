import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/screens/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/widgets/List/incubatorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorScreen extends StatelessWidget {
  static const routeName = '/incubatorscreen';

  @override
  Widget build(BuildContext context) {

    return ScopedModel<IncubatorModel>(
      model: incubatorModel,
      child: ScopedModelDescendant<IncubatorModel>(
        builder: (BuildContext context, Widget childWidget,
            IncubatorModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Incubator List',style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: (){
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
  }
}
