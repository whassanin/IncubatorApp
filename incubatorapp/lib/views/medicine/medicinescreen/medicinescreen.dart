import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/views/medicine/medicinescreen/newmedicinescreen.dart';
import 'package:incubatorapp/widgets/List/medicinelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class MedicineScreen extends StatelessWidget {
  static const routeName = '/medicinescreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MedicineModel>(
      model: medicineModel,
      child: ScopedModelDescendant<MedicineModel>(
        builder: (BuildContext context, Widget childWidget,
            MedicineModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title:
                  Text('Medicine List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewMedicineScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: MedicineListWidget(
              medicineList: medicineModel.medicineList,
            ),
          );
        },
      ),
    );
  }
}
