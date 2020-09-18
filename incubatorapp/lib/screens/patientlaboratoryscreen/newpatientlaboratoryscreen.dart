import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/scopedmodels/patientlaboratorymodel.dart';
import 'package:incubatorapp/widgets/List/laboratorylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientLaboratoryScreen extends StatefulWidget {
  static const routeName = '/newpatientlaboratoryscreen';

  final Patient patient;
  NewPatientLaboratoryScreen({
    this.patient,
  });

  @override
  _NewPatientLaboratoryScreenState createState() => _NewPatientLaboratoryScreenState();
}

class _NewPatientLaboratoryScreenState extends State<NewPatientLaboratoryScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    laboratoryModel.setSearchName('');
    laboratoryModel.readAll();
    patientLaboratoryModel.setIsAdding(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientLaboratoryModel.setIsAdding(true);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientLaboratoryModel>(
      model: patientLaboratoryModel,
      child: ScopedModelDescendant(builder:
          (BuildContext context, Widget child, PatientLaboratoryModel patientLaboratoryModel) {
        return ScopedModel<LaboratoryModel>(
          model: laboratoryModel,
          child: ScopedModelDescendant(
            builder: (BuildContext context, Widget child,
                LaboratoryModel laboratoryModel) {
              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    color: Colors.white,
                  ),
                  title: Text(
                    'Add Laboratory to Patient',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                body: LaboratoryListWidget(
                  patient: widget.patient,
                  laboratoryList: laboratoryModel.laboratoryList,
                ),
              );
            },
          ),
        );
      },),
    );
  }
}
