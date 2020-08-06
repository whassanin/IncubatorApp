import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/screens/user/userpermission.dart';

class PatientConsumableNurseRowWidget extends StatefulWidget {
  final PatientConsumableNurse patientConsumableNurse;
  final UserPermission userPermission;
  PatientConsumableNurseRowWidget({this.patientConsumableNurse,this.userPermission});
  @override
  _PatientConsumableNurseRowWidgetState createState() =>
      _PatientConsumableNurseRowWidgetState();
}

class _PatientConsumableNurseRowWidgetState extends State<PatientConsumableNurseRowWidget> {

  String dateFormat() {
    String v = widget.patientConsumableNurse.createdDate.day.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.month.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.year.toString();
    return v;
  }

  Widget patientConsumableNurseRow() {
    Consumable consumable = consumableModel.consumableList
        .where((element) => element.id == widget.patientConsumableNurse.consumableId)
        .toList()[0];

    Widget consumableNameWidget = Container(
      child: Text('Name: '+consumable.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + consumable.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Quantity: '+widget.patientConsumableNurse.quantity.toString()),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: '+dateFormat()),
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: consumableNameWidget,
        ),
        (widget.userPermission.isPatient
            ? Padding(
          padding: const EdgeInsets.all(2.0),
          child: priceWidget,
        )
            : Container()),
        (widget.userPermission.isPatient
            ? SizedBox(
          height: 5,
        )
            : Container()),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        )
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayCol,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10,),)
      ),
      elevation: 4,
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: displayCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return patientConsumableNurseRow();
  }
}
