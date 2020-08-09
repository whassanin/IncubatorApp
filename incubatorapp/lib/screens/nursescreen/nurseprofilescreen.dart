import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/screens/nursescreen/editnursescreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NurseProfileScreen extends StatelessWidget {
  static const routeName = '/nurseprofilescreen';

  final UserPermission userPermission;
  NurseProfileScreen({this.userPermission}) {
    nurseModel.readById('1');
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: nurseModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, NurseModel nurseModel) {
          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if (nurseModel.currentNurse != null) {
            if (nurseModel.currentNurse.id != null) {
              currentWidget = IndexedStack(
                index: nurseModel.currentTab,
                children: <Widget>[
                  PatientListScreen(
                    userPermission: userPermission,
                  ),
                  Center(
                    child: Container(
                      child: Text('Nurse Shift'),
                    ),
                  ),
                  EditNurseScreen()
                ],
              );
            }
          }

          String title = 'Profile';

          if (patientModel.currentTab == 0) {
            title = 'Patient List';
          } else if (patientModel.currentTab == 1) {
            title = 'Shift';
          } else if (patientModel.currentTab == 2) {
            title = 'Account';
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: currentWidget,
            bottomNavigationBar: BottomNavigatorWidget(userPermission),
          );
        },
      ),
    );
  }
}
