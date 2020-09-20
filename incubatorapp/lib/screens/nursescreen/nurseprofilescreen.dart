import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/screens/nursescreen/editnursescreen.dart';
import 'package:incubatorapp/screens/nurseshiftscreen/newnurseshiftscreen.dart';
import 'package:incubatorapp/screens/nurseshiftscreen/nurseshiftscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/drawer/drawerWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NurseProfileScreen extends StatelessWidget {
  static const routeName = '/nurseprofilescreen';

  NurseProfileScreen();

  @override
  Widget build(BuildContext context) {

    nurseModel.readById('2');

    return ScopedModel<NurseModel>(
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
                  PatientListScreen(),
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
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (nurseModel.currentTab == 1
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
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
            drawer: DrawerWidget(),
          );
        },
      ),
    );
  }
}
