import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/widgets/form/laboratoryformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewLaboratoryWebPage extends StatelessWidget {
  static const routeName = '/newlaboratorywebpage';

  NewLaboratoryWebPage();

  @override
  Widget build(BuildContext context) {
    laboratoryModel.createLaboratory();
    return ScopedModel<LaboratoryModel>(
      model: laboratoryModel,
      child: ScopedModelDescendant<LaboratoryModel>(
        builder: (BuildContext context, Widget childWidget,
            LaboratoryModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New Laboratory Web Page',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: LaboratoryFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
