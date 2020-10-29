import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/views/laboratory/laboratoryscreen/newlaboratoryscreen.dart';
import 'package:incubatorapp/widgets/List/laboratorylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class LaboratoryScreen extends StatelessWidget {
  static const routeName = '/laboratoryscreen';

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
              title:
                  Text('Laboratory List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLaboratoryScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: LaboratoryListWidget(
              laboratoryList: laboratoryModel.laboratoryList,
            ),
          );
        },
      ),
    );
  }
}
