import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/views/medicine/medicinewebpage/newmedicinewebpage.dart';
import 'package:incubatorapp/widgets/List/medicinelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class MedicineWebPage extends StatelessWidget {
  static const routeName = '/medicinewebpage';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MedicineModel>(
      model: medicineModel,
      child: ScopedModelDescendant<MedicineModel>(
        builder: (BuildContext context, Widget childWidget,
            MedicineModel incubatorModel) {
          Widget addMedicine = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      child: Text('New Medicine'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewMedicineWebPage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );

          Widget searchMedicine = Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Search here...'),
                      onChanged: (v) {
                        medicineModel.search(v);
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
                addMedicine,
                searchMedicine,
                Expanded(
                  child: MedicineListWidget(
                    medicineList: (medicineModel.searchMedicineList.length > 0
                        ? medicineModel.searchMedicineList
                        : medicineModel.medicineList),
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
