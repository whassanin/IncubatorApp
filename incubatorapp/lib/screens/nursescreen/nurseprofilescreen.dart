import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/screens/nursescreen/editnursescreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/screens/shiftscreen/newnurseshiftscreen.dart';
import 'package:incubatorapp/screens/shiftscreen/nurseshiftscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NurseProfileScreen extends StatelessWidget {
  static const routeName = '/nurseprofilescreen';

  final UserPermission userPermission;
  NurseProfileScreen({this.userPermission}) {
    nurseModel.readById(userModel.getId().toString());
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
            if (nurseModel.currentNurse.userId != null) {
              currentWidget = IndexedStack(
                index: nurseModel.currentTab,
                children: <Widget>[
                  PatientListScreen(
                    userPermission: userPermission,
                  ),
                  NurseShiftScreen(),
                  EditNurseScreen()
                ],
              );
            }
          }

          String title = 'Profile';

          if (nurseModel.currentTab == 0) {
            title = 'Patient List';
          } else if (nurseModel.currentTab == 1) {
            title = 'Shift';
          } else if (nurseModel.currentTab == 2) {
            title = 'Account';
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title,style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (nurseModel.currentTab == 1
                    ? IconButton(
                  icon: Icon(Icons.add,color: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewNurseShiftScreen(),
                      ),
                    );
                  },
                )
                    : Container())
              ],
            ),
            body: currentWidget,
            bottomNavigationBar: BottomNavigatorWidget(userPermission),
          );
        },
      ),
    );
  }
}
