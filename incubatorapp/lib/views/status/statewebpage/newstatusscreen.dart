import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/widgets/form/statusformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewStatusScreen extends StatefulWidget {
  static const routeName = '/newstatusscreen';
  final Patient patient;
  NewStatusScreen({this.patient});

  @override
  _NewStatusScreenState createState() => _NewStatusScreenState();
}

class _NewStatusScreenState extends State<NewStatusScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    statusModel.readByPatientId(patientModel.currentPatient.userId);
  }

  @override
  Widget build(BuildContext context) {
    statusModel.createStatus();
    return ScopedModel<StatusModel>(
      model: statusModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            StatusModel statusModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Add Status',style: TextStyle(color: Colors.white)),
            ),
            body: StatusFormWidget(
              patient: widget.patient,
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
