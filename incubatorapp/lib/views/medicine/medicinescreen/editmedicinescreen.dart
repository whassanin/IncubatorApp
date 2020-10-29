import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/widgets/form/medicineformwidget.dart';
import 'package:scoped_model/scoped_model.dart';
class EditMedicineScreen extends StatelessWidget {
  static const routeName = '/editmedicinescreen';
  EditMedicineScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MedicineModel>(
      model: medicineModel,
      child: ScopedModelDescendant<MedicineModel>(
        builder: (BuildContext context, Widget childWidget,
            MedicineModel medicineModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Edit Medicine Screen',style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: MedicineFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
