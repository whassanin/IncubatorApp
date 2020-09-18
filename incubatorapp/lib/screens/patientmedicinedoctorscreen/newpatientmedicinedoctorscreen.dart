import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/widgets/List/medicinelistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientMedicineDoctorScreen extends StatefulWidget {
  static const routeName = '/newpatientmedicinedoctorscreen';

  final Patient patient;
  NewPatientMedicineDoctorScreen({
    this.patient,
  });

  @override
  _NewPatientMedicineDoctorScreenState createState() =>
      _NewPatientMedicineDoctorScreenState();
}

class _NewPatientMedicineDoctorScreenState
    extends State<NewPatientMedicineDoctorScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    medicineModel.setSearchName('');
    medicineModel.readAll();
    patientMedicineDoctorModel.setIsAdding(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientMedicineDoctorModel.setIsAdding(true);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientMedicineDoctorModel>(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return ScopedModel<MedicineModel>(
            model: medicineModel,
            child: ScopedModelDescendant(
              builder: (BuildContext context, Widget child,
                  MedicineModel medicineModel) {
                return Scaffold(
                  appBar: AppBar(
                    leading: BackButton(
                      color: Colors.white,
                    ),
                    title: Text('Add Medicine to Patient',
                        style: TextStyle(color: Colors.white)),
                  ),
                  body: MedicineListWidget(
                    patient: widget.patient,
                    medicineList: medicineModel.medicineList,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
