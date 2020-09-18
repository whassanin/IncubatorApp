import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientlaboratorymodel.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/newpatientlaboratoryscreen.dart';
import 'package:incubatorapp/widgets/List/patientlaboratorylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientLaboratoryScreen extends StatelessWidget {
  static const routeName = '/patientlaboratoryscreen';

  final Patient patient;
  PatientLaboratoryScreen({this.patient,});

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
              title: Text('Laboratory',style: TextStyle(color: Colors.white),),
              actions: <Widget>[
                (userPermission.isDoctor == true?IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPatientLaboratoryScreen(
                          patient: patient,
                        ),
                      ),
                    );
                  },
                ):Container())
              ],
            ),
            body: PatientLaboratoryListWidget(
              patientLaboratoryList: patientLaboratoryModel.patientLaboratoryList,
            ),
          );
        },
      ),
    );
  }
}
