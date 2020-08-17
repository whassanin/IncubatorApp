import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NewDoctorScreen(),
      ),
    );
  }

  void navigateToNewNurseScreen() {
    userModel.setUserType(UserType.nurse);
    nurseModel.createNurse();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NewNurseScreen(),
      ),
    );
  }

  void navigateToNewPatientScreen() {
    userModel.setUserType(UserType.patient);
    patientModel.createPatient();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NewPatientScreen(),
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
          child: columnWidget),
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
    double w = MediaQuery.of(context).size.width * 0.4;
    double h = MediaQuery.of(context).size.height / 5;

    Widget doctorImage = imageWidget(
      'assets/doctor.png',
      'Doctor',
      w,
      h,
      fun: navigateToNewDoctorScreen,
    );
    Widget nurseImage = imageWidget(
      'assets/nurse.png',
      'Nurse',
      w,
      h,
      fun: navigateToNewNurseScreen,
    );
    Widget patientImage = imageWidget(
      'assets/patient.png',
      'Patient',
      w,
      h,
      fun: navigateToNewPatientScreen,
    );

    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              doctorImage,
              nurseImage,
              patientImage,
            ],
          ),
        ),
      ),
    );
  }
}
