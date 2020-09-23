import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/patientconsumablenursescreen/editconsumablenursescreen.dart';

class PatientConsumableNurseRowWidget extends StatefulWidget {
  final PatientConsumableNurse patientConsumableNurse;
  PatientConsumableNurseRowWidget({
    this.patientConsumableNurse,
  });
  @override
  _PatientConsumableNurseRowWidgetState createState() =>
      _PatientConsumableNurseRowWidgetState();
}

class _PatientConsumableNurseRowWidgetState
    extends State<PatientConsumableNurseRowWidget> {
  String dateFormat() {
    String v = widget.patientConsumableNurse.createdDate.day.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.month.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.year.toString();
    return v;
  }

  Widget displayRow(String title, String val) {
    return Row(
      children: [
        Container(
          child: Text(title),
          width: 70,
        ),
        Container(
          child: Text(
            val,
            softWrap: true,
          ),
          width: 250,
        ),
      ],
    );
  }

  Widget patientConsumableNurseRow(Consumable consumable) {
    String title = 'Name: ' + consumable.name;

    Widget consumableNameWidget = displayRow('Name:', consumable.name);

    Widget priceWidget = displayRow('Price:', consumable.price.toString());

    Widget resultWidget = displayRow(
        'Quantity:', widget.patientConsumableNurse.quantity.toString());

    Widget createdDateWidget = displayRow('Date:', dateFormat());

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: consumableNameWidget,
        ),
        (userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: priceWidget,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        )
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            displayCol, /*counterWidget()*/
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      )),
      elevation: 4,
    );

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: displayCard,
      ),
      onTap: () {
        if (userPermission.isNurse) {
          patientConsumableNurseModel
              .editPatientConsumableNurse(widget.patientConsumableNurse);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPatientConsumableNurseScreen(
                consumable: consumable,
                patientConsumableNurse: widget.patientConsumableNurse,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Container();

    if (consumableModel.consumableList != null) {
      if (consumableModel.consumableList.length > 0) {
        int index = consumableModel.consumableList.indexWhere((element) =>
            element.id == widget.patientConsumableNurse.consumableId);
        if (index >= 0) {
          Consumable consumable = consumableModel.consumableList[index];
          currentWidget = patientConsumableNurseRow(consumable);
        }
      }
    }

    return currentWidget;
  }
}
