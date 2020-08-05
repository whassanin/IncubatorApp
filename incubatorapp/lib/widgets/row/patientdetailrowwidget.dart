import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:incubatorapp/screens/analysisscreen/patientanalysisscreen.dart';
import 'package:incubatorapp/screens/xrayscreen/patientxrayscreen.dart';
import 'package:incubatorapp/screens/medicinescreen/patientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/consumablescreen/patientconsumablenursescreen.dart';

class PatientDetailRowWidget extends StatefulWidget {
  final Patient patient;
  final Status status;
  PatientDetailRowWidget({this.patient, this.status});

  @override
  _PatientDetailRowWidgetState createState() => _PatientDetailRowWidgetState();
}

class _PatientDetailRowWidgetState extends State<PatientDetailRowWidget> {
  void goToAnalysisScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientAnalysisScreen(
          patientId: widget.patient.id,
        ),
      ),
    );
  }

  void goToXRayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientXRayScreen(
          patientId: widget.patient.id,
        ),
      ),
    );
  }

  void goToMedicineScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientMedicineDoctorScreen(
          patientId: widget.patient.id,
        ),
      ),
    );
  }

  void goToConsumableScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientConsumableNurseScreen(
          patientId: widget.patient.id,
        ),
      ),
    );
  }

  String dateFormat() {
    String v = widget.patient.dateOfBirth.day.toString();
    v = v + '/' + widget.patient.dateOfBirth.month.toString();
    v = v + '/' + widget.patient.dateOfBirth.year.toString();
    return v;
  }

  Widget patientColumn(String title, String val) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide.none,
            left: BorderSide.none,
            bottom: BorderSide(width: 1, color: Colors.black),
            right: BorderSide(width: 1, color: Colors.black),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Text(title),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                child: Center(child: Text(val)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget patientInformationRow() {
    return GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: <Widget>[
        patientColumn('Mother Name:', widget.patient.motherName),
        patientColumn('Father Name:', widget.patient.fatherName),
        patientColumn('Gender:', (widget.patient.gender ? 'Male' : 'Female')),
        patientColumn('Date of Birth:', dateFormat()),
      ],
    );
  }

  Widget statusColumn(
    Icon icon,
    double iconSize,
    String title,
    String val,
  ) {
    Widget rowIcon = Padding(
      padding:
          const EdgeInsets.only(left: 10, right: 8.0, bottom: 8.0, top: 8.0),
      child: icon,
    );

    Widget rowText = Padding(
      padding:
          const EdgeInsets.only(left: 10, right: 8.0, bottom: 8.0, top: 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              softWrap: true,
            ),
            Text(val),
          ],
        ),
      ),
    );

    Widget rowData = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: iconSize, child: rowIcon),
          Expanded(child: rowText),
        ],
      ),
    );

    return Center(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide.none,
            left: BorderSide.none,
            bottom: BorderSide(width: 1, color: Colors.black),
            right: BorderSide(width: 1, color: Colors.black),
          ),
        ),
        child: rowData,
      ),
    );
  }

  Widget statusRow() {
    return Column(
      children: <Widget>[
        GridView.count(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: <Widget>[
            statusColumn(
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.blueAccent,
                ),
                50,
                'Hear Rate',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.signal,
                  color: Colors.blueAccent,
                ),
                50,
                'Pulse',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.temperatureHigh,
                  color: Colors.blueAccent,
                ),
                50,
                'Urine',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.temperatureHigh,
                  color: Colors.blueAccent,
                ),
                50,
                'Sugar',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.blueAccent,
                ),
                50,
                'Stool',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.blueAccent,
                ),
                50,
                'Weight',
                '56'),
          ],
        ),
        GridView.count(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: 4,
          children: <Widget>[
            statusColumn(
                Icon(
                  FontAwesomeIcons.temperatureHigh,
                  color: Colors.blueAccent,
                ),
                50,
                'Temperature',
                '56'),
            statusColumn(
                Icon(
                  FontAwesomeIcons.temperatureHigh,
                  color: Colors.blueAccent,
                ),
                50,
                'Incubator Temperature',
                '56'),
          ],
        )
      ],
    );
  }

  Widget rowTitle(String title) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide.none,
                left: BorderSide(width: 1, color: Colors.black),
                bottom: BorderSide(width: 1, color: Colors.black),
                right: BorderSide(width: 1, color: Colors.black),
              ),
            ),
            height: 70,
            child: Center(
                child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }

  Widget rowButton(Icon icon, String title, {fun}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: icon,
              ),
              Text(title),
            ],
          ),
          onPressed: () {
            if (fun != null) {
              fun();
            }
          },
        ),
      ),
    );
  }

  Widget displayButtons() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
        shrinkWrap: true,
        children: <Widget>[
          rowButton(
              Icon(
                FontAwesomeIcons.list,
                color: Colors.blueAccent,
              ),
              'Analysis',
              fun: goToAnalysisScreen),
          rowButton(
              Icon(
                FontAwesomeIcons.xRay,
                color: Colors.blueAccent,
              ),
              'XRay',
              fun: goToXRayScreen),
          rowButton(
              Icon(
                FontAwesomeIcons.pills,
                color: Colors.blueAccent,
              ),
              'Medicine',
              fun: goToMedicineScreen),
          rowButton(
              Icon(
                FontAwesomeIcons.thList,
                color: Colors.blueAccent,
              ),
              'Consumable',
              fun: goToConsumableScreen),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          rowTitle('Information'),
          patientInformationRow(),
          rowTitle('Status'),
          statusRow(),
          displayButtons()
        ],
      ),
    );
  }
}
