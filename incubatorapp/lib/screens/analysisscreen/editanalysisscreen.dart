import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/analysismodel.dart';
import 'package:incubatorapp/widgets/form/analysisformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditAnalysisScreen extends StatelessWidget {
  static const routeName = '/editanalysisscreen';
  EditAnalysisScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AnalysisModel>(
      model: analysisModel,
      child: ScopedModelDescendant<AnalysisModel>(
        builder: (BuildContext context, Widget childWidget,
            AnalysisModel analysisModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit Analysis Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: AnalysisFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
