import 'package:flutter/material.dart';

class UserTypeFromWidget extends StatefulWidget {
  @override
  _UserTypeFromWidgetState createState() => _UserTypeFromWidgetState();
}

class _UserTypeFromWidgetState extends State<UserTypeFromWidget> {
  Widget imageWidget(String imageLocation, String title, double w, double h) {
    return Center(
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: w,
                height: h,
                child: Image.asset(
                  imageLocation,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.4;
    double h = MediaQuery.of(context).size.height / 5;

    Widget doctorImage = imageWidget('assets/doctor.png', 'Doctor', w, h);
    Widget nurseImage = imageWidget('assets/nurse.png', 'Nurse', w, h);
    Widget patientImage = imageWidget('assets/patient.png', 'Patient', w, h);

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
