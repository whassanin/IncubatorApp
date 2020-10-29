import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/incubator.dart';
import 'package:incubatorapp/views/incubator/incubatorscreen/editincubatorscreen.dart';
import 'package:incubatorapp/views/incubator/incubatorwebpage/editincubatorwebpage.dart';

class IncubatorRowWidget extends StatefulWidget {
  final Incubator incubator;
  IncubatorRowWidget({this.incubator});
  @override
  _IncubatorRowWidgetState createState() => _IncubatorRowWidgetState();
}

class _IncubatorRowWidgetState extends State<IncubatorRowWidget> {

  void navigate(){
    if (webPageModel.isWeb) {
      incubatorModel.editIncubator(widget.incubator);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditIncubatorWebPage(),
        ),
      );
    } else {
      if (userPermission.isDoctor) {
        update();
      } else if (userPermission.isAccountant) {
        incubatorModel.editIncubator(widget.incubator);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditIncubatorScreen(),
          ),
        );
      }
    }
  }

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void update() {
    int index = findIncubator();
    if (index < 0) {
      save();
    }
  }

  int findIncubator() {
    int index = -1;

    if (userPermission.isDoctor || userPermission.isNurse) {
      if (patientModel.currentPatient != null) {
        if (widget.incubator.id == patientModel.currentPatient.incubatorId) {
          index = 1;
        }
      }
    }
    return index;
  }

  void save() async {
    patientModel.setIncubatorId(widget.incubator.id);
    patientModel.update();
  }

  Widget row() {
    int index = findIncubator();

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if (index >= 0) {
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text('Number: ' + widget.incubator.name,
                style: TextStyle(color: textColor)),
          ),
        ),
      ],
    );

    Widget rowContainer = Container(
      height: 70,
      child: Padding(padding: const EdgeInsets.only(left: 10), child: rowData),
    );

    Widget rowCard = Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: rowContainer,
    );

    return GestureDetector(
      onTap: () {
        navigate();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        child: rowCard,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
