import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/screens/doctorscreen/editdoctorscreen.dart';
import 'package:incubatorapp/screens/doctorshiftscreen/doctorshiftscreen.dart';
import 'package:incubatorapp/screens/doctorshiftscreen/newdoctorshiftscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/drawer/drawerWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class DoctorProfileScreen extends StatelessWidget {
  static const routeName = '/doctorprofilescreen';

  DoctorProfileScreen();

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
            if (doctorModel.currentDoctor.userId != null) {
              currentWidget = IndexedStack(
                index: doctorModel.currentTab,
                children: <Widget>[
                  PatientListScreen(),
                  DoctorShiftScreen(),
                  EditDoctorScreen()
                ],
              );
            }
          }

          String title = 'Profile';

          if (doctorModel.currentTab == 0) {
            title = 'Patient List';
          } else if (doctorModel.currentTab == 1) {
            title = 'Shift';
          } else if (doctorModel.currentTab == 2) {
            title = 'Account';
          }

          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (doctorModel.currentTab == 1
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewDoctorShiftScreen(),
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
