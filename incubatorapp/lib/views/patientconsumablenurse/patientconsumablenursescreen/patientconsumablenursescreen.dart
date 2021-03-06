import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/views/patientconsumablenurse/patientconsumablenursescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/widgets/List/patientconsumablenurselistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientConsumableNurseScreen extends StatefulWidget {
  static const routeName = '/patientconsumablenursescreen';

  final Patient patient;
  PatientConsumableNurseScreen({
    this.patient,
  });

  @override
  _PatientConsumableNurseScreenState createState() =>
      _PatientConsumableNurseScreenState();
}

class _PatientConsumableNurseScreenState
    extends State<PatientConsumableNurseScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PatientConsumableNurseModel>(
      model: patientConsumableNurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            PatientConsumableNurseModel patientConsumableNurseModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Consumable', style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isNurse
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          patientConsumableNurseModel.setIsLoading(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewPatientConsumableNurseScreen(),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: PatientConsumableNurseListWidget(
              patientConsumableNurseList:
                  patientConsumableNurseModel.patientConsumableNurseList,
            ),
          );
        },
      ),
    );
  }
}
