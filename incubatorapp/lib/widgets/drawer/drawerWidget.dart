import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/contactusscreen/contactusscreen.dart';
import 'package:incubatorapp/screens/creditcardscreen/creditcardscreen.dart';
import 'package:incubatorapp/screens/historyscreen/historyscreen.dart';
import 'package:incubatorapp/screens/loginscreen/signinscreen.dart';
import 'package:incubatorapp/screens/reportscreen/reportscreen.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void navigateToCreditCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreditCardScreen(),
      ),
    );
  }

  void navigateToReport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(),
      ),
    );
  }

  void navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(),
      ),
    );
  }

  void navigateToContactUs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactUsScreen(),
      ),
    );
  }

  void navigateToWelcomeScreen() {
    userModel.editUser(null);
    userPermission.setPermission(UserType.none);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
      ModalRoute.withName('/welcomescreen'),
    );
  }

  Widget header(
    String imagePath,
    String type,
    String email,
  ) {
    Widget imageHeader = Expanded(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget title = Padding(
      padding: const EdgeInsets.all(8),
      child: Text(type + ' email: ' + email),
    );

    Widget columnHeader = Column(
      children: <Widget>[imageHeader, title],
    );

    return Container(
      height: 300,
      color: Colors.white,
      child: columnHeader,
    );
  }

  Widget childDrawer(String title, {VoidCallback fun}) {
    Widget containerDrawer = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide.none,
          left: BorderSide.none,
          bottom: BorderSide(width: 1, color: Colors.white),
          right: BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: containerDrawer,
      ),
      onTap: () {
        if (fun != null) {
          fun();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget headerData = Container();

    if (userPermission.isDoctor) {
      headerData = header('assets/doctor.png', 'Doctor', userModel.getEmail());
    } else if (userPermission.isNurse) {
      headerData = header('assets/nurse.png', 'Nurse', userModel.getEmail());
    } else if (userPermission.isPatient) {
      headerData =
          header('assets/patient.png', 'Patient', userModel.getEmail());
    } else if (userPermission.isAccountant) {
      headerData =
          header('assets/patient.png', 'Accountant', userModel.getEmail());
    }

    return Drawer(
      child: Container(
        color: Colors.cyan,
        child: ListView(
          children: <Widget>[
            headerData,
            (userPermission.isPatient
                ? childDrawer(
                    'My Credit Card',
                    fun: navigateToCreditCard,
                  )
                : Container()),
            childDrawer(
              'Report a problem',
              fun: navigateToReport,
            ),
            childDrawer(
              'History',
              fun: navigateToHistory,
            ),
            childDrawer(
              'Contact Us',
              fun: navigateToContactUs,
            ),
            childDrawer(
              'Log Out',
              fun: navigateToWelcomeScreen,
            ),
          ],
        ),
      ),
    );
  }
}
