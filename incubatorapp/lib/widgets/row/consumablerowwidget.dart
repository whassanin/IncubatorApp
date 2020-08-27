import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';

class ConsumableRowWidget extends StatefulWidget {
  final Patient patient;
  final Consumable consumable;
  final UserPermission userPermission;
  ConsumableRowWidget({
    this.patient,
    this.consumable,
    this.userPermission,
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
    int index = findConsumable();
    if (index >= 0) {
      delete(index);
    } else if (index < 0) {
      save();
    }
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

  void delete(int index) {
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
    int index = findConsumable();

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if (index >= 0) {
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text(
          'Id: ' + widget.consumable.id.toString(),
          style: TextStyle(color: textColor),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.consumable.name,
              style: TextStyle(color: textColor),
            ),
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
        if (widget.userPermission.isNurse) {
          update();
        } else {}
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
