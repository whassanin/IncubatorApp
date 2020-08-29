import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/accountantscreen/newaccountantscreen.dart';
import 'package:incubatorapp/screens/doctorscreen/newdoctorscreen.dart';
import 'package:incubatorapp/screens/nursescreen/newnursescreen.dart';
import 'package:incubatorapp/screens/patientscreen/newpatientscreen.dart';

class UserTypeFromWidget extends StatefulWidget {
  @override
  _UserTypeFromWidgetState createState() => _UserTypeFromWidgetState();
}

class _UserTypeFromWidgetState extends State<UserTypeFromWidget> {
  void navigateToNewDoctorScreen() {
    userModel.setUserType(UserType.doctor);
    doctorModel.createDoctor();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewDoctorScreen(),
      ),
    );
  }

  void navigateToNewNurseScreen() {
    userModel.setUserType(UserType.nurse);
    nurseModel.createNurse();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewNurseScreen(),
      ),
    );
  }

  void navigateToNewPatientScreen() {
    userModel.setUserType(UserType.patient);
    patientModel.createPatient();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPatientScreen(),
      ),
    );
  }

  void navigateToNewAccountantScreen() {
    userModel.setUserType(UserType.accountant);
    accountantModel.createAccountant();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewAccountantScreen(),
      ),
    );
  }

  Widget imageWidget(String imageLocation, String title, double w, double h,
      {VoidCallback fun}) {
    Widget imageWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: w,
        height: h,
        child: Image.asset(
          imageLocation,
          fit: BoxFit.fill,
        ),
      ),
    );

    Widget titleWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title),
    );

    Widget columnWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[imageWidget, titleWidget],
    );

    Widget cardWidget = Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: columnWidget,
      ),
    );

    return GestureDetector(
      child: cardWidget,
      onTap: () {
        if (fun != null) {
          fun();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double iw = MediaQuery.of(context).size.width * 0.4;
    double ih = MediaQuery.of(context).size.height / (5);

    Widget doctorImage = imageWidget(
      'assets/doctor.png',
      'Doctor',
      iw,
      ih,
      fun: navigateToNewDoctorScreen,
    );
    Widget nurseImage = imageWidget(
      'assets/nurse.png',
      'Nurse',
      iw,
      ih,
      fun: navigateToNewNurseScreen,
    );
    Widget patientImage = imageWidget(
      'assets/patient.png',
      'Patient',
      iw,
      ih,
      fun: navigateToNewPatientScreen,
    );
    Widget frontDeskImage = imageWidget(
        'assets/patient.png', 'Accountant', iw, ih,
        fun: navigateToNewAccountantScreen);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height - 85;

    return GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: w / h,
      children: <Widget>[
        doctorImage,
        nurseImage,
        patientImage,
        frontDeskImage,
      ],
    );
  }
}
