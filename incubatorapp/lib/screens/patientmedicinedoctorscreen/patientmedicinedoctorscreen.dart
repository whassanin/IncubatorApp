import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/screens/patientmedicinedoctorscreen/newpatientmedicinedoctorscreen.dart';
import 'package:incubatorapp/widgets/List/patientmedicinedoctorlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientMedicineDoctorScreen extends StatefulWidget {
  static const routeName = '/patientmedicinedoctorscreen';

  final Patient patient;
  PatientMedicineDoctorScreen({this.patient,});

  @override
  _PatientMedicineDoctorScreenState createState() => _PatientMedicineDoctorScreenState();
}

class _PatientMedicineDoctorScreenState extends State<PatientMedicineDoctorScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patientMedicineDoctorModel.clearList();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModel<PatientMedicineDoctorModel>(
      model: patientMedicineDoctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientMedicineDoctorModel patientMedicineDoctorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Medicine',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isDoctor == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewPatientMedicineDoctorScreen(
                                patient: widget.patient,
                              ),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientMedicineDoctorListWidget(
              patientMedicineDoctorList:
                  patientMedicineDoctorModel.patientMedicineDoctorList,
            ),
          );
        },
      ),
    );
  }
}
