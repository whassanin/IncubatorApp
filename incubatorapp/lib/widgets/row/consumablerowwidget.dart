import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';

class ConsumableRowWidget extends StatefulWidget {
  final Patient patient;
  final Consumable consumable;
  final UserPermission userPermission;
  ConsumableRowWidget(
      {this.patient,
      this.consumable,
      this.userPermission,});
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

  void validate() {
    String dn = dateFormat(DateTime.now());

    int i = patientConsumableNurseModel.patientConsumableNurseList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.consumableId == widget.consumable.id &&
            element.nurseId == nurseModel.currentNurse.id &&
            dateFormat(element.createdDate) == dn);
    if (i >= 0) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  void save() {
    patientConsumableNurseModel.createPatientConsumableNurse();
    patientConsumableNurseModel.setPatientId(widget.patient.id);
    patientConsumableNurseModel.setConsumableId(widget.consumable.id);
    patientConsumableNurseModel.setNurseId(nurseModel.currentNurse.id);
    patientConsumableNurseModel.setQuantity(1);
    patientConsumableNurseModel.create();
  }

  void delete() {
    String dn = dateFormat(DateTime.now());

    patientConsumableNurseModel.createPatientConsumableNurse();
    patientConsumableNurseModel.setPatientId(widget.patient.id);
    patientConsumableNurseModel.setConsumableId(widget.consumable.id);
    patientConsumableNurseModel.setNurseId(nurseModel.currentNurse.id);

    int i = patientConsumableNurseModel.patientConsumableNurseList.indexWhere(
            (element) =>
        element.patientId == widget.patient.id &&
            element.consumableId == widget.consumable.id &&
            element.nurseId == nurseModel.currentNurse.id &&
            dateFormat(element.createdDate) == dn);

    if(i >= 0){
      isSelected = true;
      patientConsumableNurseModel.editPatientConsumableNurse(patientConsumableNurseModel.patientConsumableNurseList[i]);
      patientConsumableNurseModel.delete();
    }

  }

  Widget row() {
    validate();

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.consumable.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(child: Text('Name: ' + widget.consumable.name))),
        (widget.userPermission.isNurse
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  if(b==true){
                    save();
                  }else {
                    delete();
                  }
                },
              )
            : Container())
      ],
    );

    Widget rowContainer = Container(
      height: 50,
      child: Padding(padding: const EdgeInsets.only(left: 10), child: rowData),
    );

    Widget rowCard = Card(
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
        if (widget.userPermission.isFrontDesk) {
        } else {

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
