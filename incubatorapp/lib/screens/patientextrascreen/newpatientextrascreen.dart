import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientextramodel.dart';
import 'package:incubatorapp/widgets/List/extralistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientExtraScreen extends StatefulWidget {
  static const routeName = '/newpatientextrascreen';

  final Patient patient;
  NewPatientExtraScreen({this.patient,});

  @override
  _NewPatientExtraScreenState createState() => _NewPatientExtraScreenState();
}

class _NewPatientExtraScreenState extends State<NewPatientExtraScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patientExtraModel.setIsAdding(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientExtraModel.setIsAdding(true);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientExtraModel>(
      model: patientExtraModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientExtraModel patientExtraModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Add Extra to Patient',style: TextStyle(color: Colors.white)),
            ),
            body: ExtraListWidget(
              patient: widget.patient,
              extraList: extraModel.extraList,
            ),
          );
        },
      ),
    );
  }
}
