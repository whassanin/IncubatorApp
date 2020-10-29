import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/views/laboratory/laboratorywebpage/newlaboratorywebpage.dart';
import 'package:incubatorapp/widgets/List/laboratorylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class LaboratoryWebPage extends StatelessWidget {
  static const routeName = '/laboratorywebpage';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LaboratoryModel>(
      model: laboratoryModel,
      child: ScopedModelDescendant<LaboratoryModel>(
        builder: (BuildContext context, Widget childWidget,
            LaboratoryModel laboratoryModel) {
          Widget addLaboratory = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      child: Text('New Laboratory'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewLaboratoryWebPage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );

          Widget searchLaboratory = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Search here...'),
                      onChanged: (v) {
                        laboratoryModel.search(v);
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
                addLaboratory,
                searchLaboratory,
                Expanded(
                  child: LaboratoryListWidget(
                    laboratoryList:
                        (laboratoryModel.searchLaboratoryList.length > 0
                            ? laboratoryModel.searchLaboratoryList
                            : laboratoryModel.laboratoryList),
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
