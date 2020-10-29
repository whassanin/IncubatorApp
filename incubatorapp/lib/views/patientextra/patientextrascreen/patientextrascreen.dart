import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientextramodel.dart';
import 'package:incubatorapp/views/patientextra/patientextrascreen/newpatientextrascreen.dart';
import 'package:incubatorapp/widgets/List/patientextralistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientExtraScreen extends StatefulWidget {
  static const routeName = '/patientextrascreen';

  final Patient patient;
  PatientExtraScreen({
    this.patient,
  });

  @override
  _PatientExtraScreenState createState() => _PatientExtraScreenState();
}

class _PatientExtraScreenState extends State<PatientExtraScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
              title: Text(
                'Extra',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                (userPermission.isDoctor == true ||
                        userPermission.isNurse == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          patientExtraModel.setIsLoading(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPatientExtraScreen(),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientExtraListWidget(
              patientExtraList: patientExtraModel.patientExtraList,
            ),
          );
        },
      ),
    );
  }
}
