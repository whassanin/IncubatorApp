import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/statetype.dart';
import 'package:incubatorapp/screens/statescreen/editstatescreen.dart';

class StateTypeRowWidget extends StatefulWidget {
  final StateType stateType;
  StateTypeRowWidget({this.stateType});
  @override
  _StateRowWidgetState createState() => _StateRowWidgetState();
}

class _StateRowWidgetState extends State<StateTypeRowWidget> {
  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void update() {
    int index = findCondition();
    if (index < 0) {
      save();
    }
  }

  int findCondition() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    if (userPermission.isDoctor || userPermission.isNurse) {
      if (patientModel.currentPatient != null) {
        if(widget.stateType.id == patientModel.currentPatient.stateTypeId){
          index = 1;
        }
      }
    }
    return index;
  }

  void save() async {
    patientModel.setStateTypeId(widget.stateType.id);
    patientModel.update();
  }

  Widget row() {
    int index = findCondition();

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
            child: Text(widget.stateType.name,
                textAlign: TextAlign.center,
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
        if(userPermission.isDoctor){
          update();
        }
        else if (userPermission.isAccountant) {
          stateTypeModel.editStateType(widget.stateType);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditStateTypeScreen(),
            ),
          );
        }
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
