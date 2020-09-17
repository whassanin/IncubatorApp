import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/screens/conditionscreen/editconditionscreen.dart';

class ConditionRowWidget extends StatefulWidget {
  final Condition condition;
  ConditionRowWidget({
    this.condition,
  });
  @override
  _ConditionRowWidgetState createState() => _ConditionRowWidgetState();
}

class _ConditionRowWidgetState extends State<ConditionRowWidget> {
  bool isSelected = false;

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

  void navigateToEditConditionScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditConditionScreen()));
  }

  int findCondition() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    if (userPermission.isDoctor || userPermission.isNurse) {
      if (patientModel.currentPatient != null) {
       if(widget.condition.id == patientModel.currentPatient.conditionId){
         index = 1;
       }
      }
    }
    return index;
  }

  void save() async {
    patientModel.setConditionId(widget.condition.id);
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
            child: Text(widget.condition.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.condition.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
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
        if (userPermission.isDoctor) {
          update();
        } else if (userPermission.isAccountant) {
          conditionModel.editCondition(widget.condition);
          navigateToEditConditionScreen();
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
