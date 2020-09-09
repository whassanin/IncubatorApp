import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/analysismodel.dart';
import 'package:incubatorapp/widgets/search/laboratorysearchwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchAnalysisScreen extends StatelessWidget {
  static const routeName = '/searchanalysisscreen';

  SearchAnalysisScreen();

  @override
  Widget build(BuildContext context) {
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
              title: Text(
                'Search Laboratory Screen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                child: SearchLaboratoryWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
