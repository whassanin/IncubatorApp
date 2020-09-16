import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/consumablescreen/editconsumablescreen.dart';

class ConsumableRowWidget extends StatefulWidget {
  final Patient patient;
  final Consumable consumable;
  ConsumableRowWidget({
    this.patient,
    this.consumable,
  });
  @override
  _ConsumableRowWidgetState createState() => _ConsumableRowWidgetState();
}

class _ConsumableRowWidgetState extends State<ConsumableRowWidget> {
  bool isSelected = false;

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void update() {
    if (isSelected) {
      isSelected = false;
      delete();
    } else {
      isSelected = true;
      save();
    }
  }

  void navigateToEditConsumableScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditConsumableScreen()));
  }

  int findConsumable() {
    int index = -1;

    patientConsumableNurseModel.patientConsumableNurseList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.consumableId == widget.consumable.id &&
          element.nurseId == nurseModel.currentNurse.userId) {
        index = patientConsumableNurseModel.patientConsumableNurseList
            .indexOf(element);
      }
    });

    return index;
  }

  void delete() {
    int index = findConsumable();
    patientConsumableNurseModel.editPatientConsumableNurse(
        patientConsumableNurseModel.patientConsumableNurseList[index]);
    patientConsumableNurseModel.delete();
  }

  void save() {
    patientConsumableNurseModel.createPatientConsumableNurse();
    patientConsumableNurseModel.setPatientId(widget.patient.userId);
    patientConsumableNurseModel.setConsumableId(widget.consumable.id);
    patientConsumableNurseModel.setNurseId(nurseModel.currentNurse.userId);
    patientConsumableNurseModel.setQuantity(1);
    patientConsumableNurseModel.create();
  }

  Widget row() {
    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if (isSelected) {
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
            child: Text(widget.consumable.name,
                style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.consumable.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Amount: ' + widget.consumable.amount.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
      ],
    );

    Widget rowContainer = Container(
      height: (userPermission.isNurse ? 70 : 98),
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
        if (userPermission.isNurse) {
          update();
        } else if (userPermission.isAccountant) {
          consumableModel.editConsumable(widget.consumable);
          navigateToEditConsumableScreen();
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
    int index = -1;
    if (widget.patient != null) {
      index = findConsumable();

      if (index > -1) {
        isSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
