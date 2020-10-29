import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/accountantmodel.dart';
import 'package:incubatorapp/views/accountant/accountantscreen/editaccountantscreen.dart';
import 'package:incubatorapp/views/menuscreen/menuscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/drawer/drawerWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountantProfileScreen extends StatelessWidget {
  static const routeName = '/accountantprofilescreen';

  AccountantProfileScreen();

  @override
  Widget build(BuildContext context) {
    //accountantModel.readById('3');

    return ScopedModel<AccountantModel>(
      model: accountantModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            AccountantModel accountantModel) {
          Widget currentWidget = Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );

          if (accountantModel.currentAccountant != null) {
            if (accountantModel.currentAccountant.userId != null) {
              currentWidget = IndexedStack(
                index: accountantModel.currentTab,
                children: <Widget>[
                  PatientListScreen(),
                  MenuScreen(),
                  EditAccountantScreen(),
                ],
              );
            }
          }

          String title = 'Profile';

          if (accountantModel.currentTab == 0) {
            title = 'Patient List';
          } else if (accountantModel.currentTab == 1) {
            title = 'Data Management';
          } else if (accountantModel.currentTab == 2) {
            title = 'Account';
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
