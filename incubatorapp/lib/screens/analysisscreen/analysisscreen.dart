import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/analysismodel.dart';
import 'package:incubatorapp/screens/analysisscreen/newanalysisscreen.dart';
import 'package:incubatorapp/widgets/List/analysislistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class AnalysisScreen extends StatelessWidget {
  static const routeName = '/analysisscreen';

  @override
  Widget build(BuildContext context) {
    incubatorModel.readAll();

    return ScopedModel<AnalysisModel>(
      model: analysisModel,
      child: ScopedModelDescendant<AnalysisModel>(
        builder: (BuildContext context, Widget childWidget,
            AnalysisModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title:
                  Text('Analysis List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAnalysisScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: AnalysisListWidget(
              analysisList: analysisModel.analysisList,
            ),
          );
        },
      ),
    );
  }
}
