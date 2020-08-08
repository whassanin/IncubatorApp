import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/screens/billscreen/billscreen.dart';
import 'package:incubatorapp/screens/doctorscreen/editdoctorscreen.dart';
import 'package:incubatorapp/screens/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientdetailscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class DoctorProfileScreen extends StatelessWidget {
  static const routeName = '/doctorprofilescreen';

  final UserPermission userPermission;
  DoctorProfileScreen({this.userPermission}) {
    doctorModel.readById('1');
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: doctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, DoctorModel doctorModel) {
          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if (doctorModel.currentDoctor != null) {
            if (doctorModel.currentDoctor.id != null) {
              currentWidget = IndexedStack(
                index: doctorModel.currentTab,
                children: <Widget>[
                  PatientListScreen(
                    userPermission: userPermission,
                  ),
                  Center(
                    child: Container(
                      child: Text('Shift'),
                    ),
                  ),
                  EditDoctorScreen()
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
