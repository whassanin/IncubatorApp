import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/widgets/List/xraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewPatientXRayScreen extends StatefulWidget {
  static const routeName = '/newpatientxrayscreen';

  final Patient patient;
  NewPatientXRayScreen({
    this.patient,
  });

  @override
  _NewPatientXRayScreenState createState() => _NewPatientXRayScreenState();
}

class _NewPatientXRayScreenState extends State<NewPatientXRayScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    xRayModel.setSearchName('');
    xRayModel.readAll();
    patientXRayModel.readByPatientId(widget.patient.userId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientXRayModel>(
      model: patientXRayModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientXRayModel patientXRayModel) {
          return ScopedModel<XRayModel>(
            model: xRayModel,
            child: ScopedModelDescendant(
              builder:
                  (BuildContext context, Widget child, XRayModel xRayModel) {
                return Scaffold(
                  appBar: AppBar(
                    leading: BackButton(
                      color: Colors.white,
                    ),
                    title: Text('Add XRay to Patient',
                        style: TextStyle(color: Colors.white)),
                  ),
                  body: XRayListWidget(
                    patient: widget.patient,
                    xRayList: xRayModel.xRayList,
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
