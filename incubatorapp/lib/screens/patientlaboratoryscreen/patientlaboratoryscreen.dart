import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientlaboratorymodel.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/newpatientlaboratoryscreen.dart';
import 'package:incubatorapp/widgets/List/patientlaboratorylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientLaboratoryScreen extends StatefulWidget {
  static const routeName = '/patientlaboratoryscreen';

  final Patient patient;
  PatientLaboratoryScreen({
    this.patient,
  });

  @override
  _PatientLaboratoryScreenState createState() =>
      _PatientLaboratoryScreenState();
}

class _PatientLaboratoryScreenState extends State<PatientLaboratoryScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientLaboratoryModel>(
      model: patientLaboratoryModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientLaboratoryModel patientLaboratoryModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text(
                'Laboratory',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                (userPermission.isDoctor == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          patientLaboratoryModel.setIsLoading(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewPatientLaboratoryScreen(),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientLaboratoryListWidget(
              patientLaboratoryList:
                  patientLaboratoryModel.patientLaboratoryList,
            ),
          );
        },
      ),
    );
  }
}
