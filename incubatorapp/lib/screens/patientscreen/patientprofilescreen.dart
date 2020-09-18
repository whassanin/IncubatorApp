import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/screens/billscreen/billscreen.dart';
import 'package:incubatorapp/screens/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientdetailscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/drawer/drawerWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientProfileScreen extends StatelessWidget {
  static const routeName = '/patientprofilescreen';

  PatientProfileScreen();

  @override
  Widget build(BuildContext context) {
    //patientModel.readById('3');
    return ScopedModel<PatientModel>(
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
            if (patientModel.currentPatient.userId != null) {
              currentWidget = IndexedStack(
                index: patientModel.currentTab,
                children: <Widget>[
                  PatientDetailScreen(),
                  BillScreen(),
                  EditPatientScreen()
                ],
              );
            }
          }

          String title = 'Profile';

          if (patientModel.currentTab == 0) {
            title = 'Patient Profile';
          } else if (patientModel.currentTab == 1) {
            title = 'Patient Bills';
          } else if (patientModel.currentTab == 2) {
            title = 'Patient Account';
          }

          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white)),
            ),
            body: currentWidget,
            bottomNavigationBar: BottomNavigatorWidget(userPermission),
            drawer: DrawerWidget(),
          );
        },
      ),
    );
  }
}
