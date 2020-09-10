import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/widgets/search/laboratorysearchwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchLaboratoryScreen extends StatelessWidget {
  static const routeName = '/searchlaboratoryscreen';

  SearchLaboratoryScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LaboratoryModel>(
      model: laboratoryModel,
      child: ScopedModelDescendant<LaboratoryModel>(
        builder: (BuildContext context, Widget childWidget,
            LaboratoryModel laboratoryModel) {
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
