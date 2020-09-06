import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/widgets/form/medicineformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewMedicineScreen extends StatelessWidget {
  static const routeName = '/newmedicinescreen';

  NewMedicineScreen();

  @override
  Widget build(BuildContext context) {
    medicineModel.createMedicine();
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
              title: Text('New Medicine Screen',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: MedicineFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
