import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/screens/billscreen/billscreen.dart';
import 'package:incubatorapp/screens/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientProfileScreen extends StatelessWidget {
  static const routeName = '/patientprofilescreen';
  PatientProfileScreen(){
    patientModel.readById('2');
  }
  @override
  Widget build(BuildContext context) {

    return ScopedModel(
      model: patientModel,
      child: ScopedModelDescendant(
        builder:
            (BuildContext context, Widget child, PatientModel patientModel) {
          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if (patientModel.currentPatient != null) {
            if (patientModel.currentPatient.id != null) {
              currentWidget = IndexedStack(
                index: patientModel.currentTab,
                children: <Widget>[
                  PatientDetailRowWidget(
                    patient: patientModel.currentPatient,
                  ),
                  BillScreen(patientId: patientModel.currentPatient.id,),
                  EditPatientScreen()
                ],
              );
            }
          }

          String title = 'Profile';

          if(patientModel.currentTab == 0){
            title = 'Patient Profile';
          }else if(patientModel.currentTab == 1){
            title = 'Patient Bills';
          }else if(patientModel.currentTab == 2){
            title = 'Patient Account';
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: currentWidget,
            bottomNavigationBar: BottomNavigatorWidget(),
          );
        },
      ),
    );
  }
}
