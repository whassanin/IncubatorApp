import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/conditionscreen/conditionscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/incubatorscreen.dart';
import 'package:incubatorapp/screens/patientconsumablenursescreen/patientconsumablenursescreen.dart';
import 'package:incubatorapp/screens/patientextrascreen/patientextrascreen.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/patientlaboratoryscreen.dart';
import 'package:incubatorapp/screens/patientmedicinedoctorscreen/patientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/patientscreen/livescreen.dart';
import 'package:incubatorapp/screens/patientxrayscreen/patientxrayscreen.dart';
import 'package:incubatorapp/screens/statescreen/statescreen.dart';
import 'package:incubatorapp/screens/statusscreen/statusscreen.dart';

class PatientDetailRowWidget extends StatefulWidget {
  final Patient patient;
  final UserPermission userPermission;
  PatientDetailRowWidget({this.patient, this.userPermission});

  @override
  _PatientDetailRowWidgetState createState() => _PatientDetailRowWidgetState();
}

class _PatientDetailRowWidgetState extends State<PatientDetailRowWidget> {
  void goToStatusScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToLaboratoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientLaboratoryScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToXRayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientXRayScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToMedicineScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientMedicineDoctorScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToConsumableScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientConsumableNurseScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToConditionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConditionScreen(true),
      ),
    );
  }

  void goToIncubatorScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncubatorScreen(true),
      ),
    );
  }

  void goToStateTypeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StateTypeScreen(true),
      ),
    );
  }

  void setLightRay() {
    if (widget.patient.isOnLightRay) {
      patientModel.setIsOnLightRay(false);
    } else {
      patientModel.setIsOnLightRay(true);
    }
  }

  void goToExtraScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientExtraScreen(
          patient: widget.patient,
        ),
      ),
    );
  }

  void goToLiveScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveScreen(),
      ),
    );
  }

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
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
        patientColumn('Date of Birth:', dateFormat(widget.patient.dateOfBirth)),
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
          const EdgeInsets.only(left: 10, right: 8.0, bottom: 3.0, top: 13.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(val),
            ),
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

  Widget statusColumnWithImage(
    String imagePath,
    double iconSize,
    String title,
    String val,
  ) {
    Widget rowIcon = Padding(
      padding:
          const EdgeInsets.only(left: 10, right: 8.0, bottom: 8.0, top: 8.0),
      child: Container(
        width: 80,
        height: 50,
        child: Image.asset(
          imagePath,
          width: 80,
          height: 50,
          fit: BoxFit.fill,
        ),
      ),
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(val),
            ),
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
    Widget currentWidget = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide.none,
                left: BorderSide(width: 1, color: Colors.black),
                bottom: BorderSide(width: 1, color: Colors.black),
                right: BorderSide(width: 1, color: Colors.black),
              ),
            ),
            child: Center(
              child: Text(
                'No Status Yet',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );

    if (widget.patient.statusList != null) {
      if (widget.patient.statusList.length > 0) {
        currentWidget = Column(
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
                      color: Colors.cyan,
                    ),
                    50,
                    'Heart Rate',
                    widget.patient.statusList[0].heartRate.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.heartbeat,
                      color: Colors.cyan,
                    ),
                    50,
                    'Pulse Rate',
                    widget.patient.statusList[0].pulseRate.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.lungs,
                      color: Colors.cyan,
                    ),
                    50,
                    'Oxygen',
                    widget.patient.statusList[0].oxygen.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.weight,
                      color: Colors.cyan,
                    ),
                    50,
                    'Weight',
                    widget.patient.statusList[0].weight.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.burn,
                      color: Colors.cyan,
                    ),
                    50,
                    'Sugar',
                    widget.patient.statusList[0].sugar.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.filePrescription,
                      color: Colors.cyan,
                    ),
                    50,
                    'Blood Pressure',
                    widget.patient.statusList[0].bloodPressure.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.poop,
                      color: Colors.cyan,
                    ),
                    50,
                    'Urine',
                    widget.patient.statusList[0].urine.toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.poop,
                      color: Colors.cyan,
                    ),
                    50,
                    'Stool',
                    widget.patient.statusList[0].stool.toString()),
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
                      color: Colors.cyan,
                    ),
                    50,
                    'Temperature',
                    widget.patient.statusList[0].temperature.toString()),
                statusColumnWithImage(
                    'assets/IncubatorIcon.png',
                    50,
                    'Incubator Temperature',
                    widget.patient.statusList[0].incubatorTemperature
                        .toString()),
                statusColumn(
                    Icon(
                      FontAwesomeIcons.calendar,
                      color: Colors.cyan,
                    ),
                    50,
                    'Latest Date',
                    dateFormat(widget.patient.statusList[0].createdDate))
              ],
            )
          ],
        );
      }
    }

    return currentWidget;
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
              ),
            ),
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
          color: Colors.cyan,
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
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
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

  Widget displayFourButtons() {
    Widget firstButton = rowButton(
        Icon(
          FontAwesomeIcons.list,
          color: Colors.white,
        ),
        'Laboratory',
        fun: goToLaboratoryScreen);

    Widget lastButton = rowButton(
        Icon(
          FontAwesomeIcons.thList,
          color: Colors.white,
        ),
        'Consumable',
        fun: goToConsumableScreen);

    if (userPermission.isNurse) {
      Widget temp = firstButton;
      firstButton = lastButton;
      lastButton = temp;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.count(
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2,
        shrinkWrap: true,
        children: <Widget>[
          firstButton,
          rowButton(
              Icon(
                FontAwesomeIcons.xRay,
                color: Colors.white,
              ),
              'XRay',
              fun: goToXRayScreen),
          rowButton(
              Icon(
                FontAwesomeIcons.pills,
                color: Colors.white,
              ),
              'Medicine',
              fun: goToMedicineScreen),
          lastButton,
        ],
      ),
    );
  }

  Widget displayDoctorButtons() {
    Widget conditionButton = Container();

    Widget incubatorButton = Container();

    Widget stateButton = Container();

    Widget isLightRayButton = Container();

    Widget currentWidget = Container();
    if (userPermission.isDoctor || userPermission.isNurse) {
      conditionButton = rowButton(
          Icon(
            FontAwesomeIcons.creativeCommonsSampling,
            color: Colors.white,
          ),
          'Change Condition',
          fun: goToConditionScreen);

      incubatorButton = rowButton(
          Icon(
            FontAwesomeIcons.procedures,
            color: Colors.white,
          ),
          'Change Incubator',
          fun: goToIncubatorScreen);

      stateButton = rowButton(
          Icon(
            Icons.verified_user,
            color: Colors.white,
          ),
          'Change State',
          fun: goToStateTypeScreen);

      isLightRayButton = rowButton(
          Icon(
            (widget.patient.isOnLightRay
                ? FontAwesomeIcons.solidLightbulb
                : FontAwesomeIcons.lightbulb),
            color: Colors.white,
          ),
          (widget.patient.isOnLightRay
              ? 'Light Ray is on'
              : 'Light Ray is Off'),
          fun: setLightRay);

      currentWidget = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.count(
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2,
          shrinkWrap: true,
          children: <Widget>[
            conditionButton,
            incubatorButton,
            stateButton,
            isLightRayButton,
          ],
        ),
      );
    }

    return currentWidget;
  }

  Widget addStatusButton() {
    Widget currentWidget = Container();

    if (widget.userPermission.isNurse || widget.userPermission.isDoctor) {
      currentWidget = Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 100,
                child: rowButton(
                    Icon(
                      Icons.view_list,
                      color: Colors.white,
                    ),
                    'View History Status',
                    fun: goToStatusScreen),
              ),
            ),
          ],
        ),
      );
    }

    return currentWidget;
  }

  Widget extraButton() {
    Widget currentWidget = Padding(
      padding: (userPermission.isPatient
          ? const EdgeInsets.only(right: 10, left: 10, bottom: 2)
          : const EdgeInsets.only(right: 10, left: 10, bottom: 10)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 100,
              child: rowButton(
                Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                  size: 30,
                ),
                'Extra',
                fun: goToExtraScreen,
              ),
            ),
          ),
        ],
      ),
    );

    return currentWidget;
  }

  Widget liveButton() {
    Widget currentWidget = Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 100,
              child: rowButton(
                Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                  size: 30,
                ),
                'Live',
                fun: goToLiveScreen,
              ),
            ),
          ),
        ],
      ),
    );

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    Condition condition;

    if (conditionModel.conditionList != null) {
      List<Condition> list = conditionModel.conditionList
          .where((c) => c.id == widget.patient.conditionId)
          .toList();
      if (list.length > 0) {
        condition = list[0];
      }
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          rowTitle('Information'),
          patientInformationRow(),
          rowTitle(
            'Condition: ' + (condition != null ? condition.name : ''),
          ),
          rowTitle(
            'Incubator Number: ' + widget.patient.incubatorId.toString(),
          ),
          rowTitle('Status'),
          statusRow(),
          addStatusButton(),
          displayFourButtons(),
          displayDoctorButtons(),
          extraButton(),
          (userPermission.isPatient ? liveButton() : Container())
        ],
      ),
    );
  }
}
