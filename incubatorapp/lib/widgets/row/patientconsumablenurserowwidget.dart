import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/userpermission.dart';

class PatientConsumableNurseRowWidget extends StatefulWidget {
  final PatientConsumableNurse patientConsumableNurse;
  final UserPermission userPermission;
  PatientConsumableNurseRowWidget(
      {this.patientConsumableNurse, this.userPermission});
  @override
  _PatientConsumableNurseRowWidgetState createState() =>
      _PatientConsumableNurseRowWidgetState();
}

class _PatientConsumableNurseRowWidgetState
    extends State<PatientConsumableNurseRowWidget> {

  TextEditingController quantityTEC = new TextEditingController();

  String dateFormat() {
    String v = widget.patientConsumableNurse.createdDate.day.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.month.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.year.toString();
    return v;
  }

  void update(int v){
    patientConsumableNurseModel.editPatientConsumableNurse(widget.patientConsumableNurse);
    patientConsumableNurseModel.setQuantity(v);
    patientConsumableNurseModel.update();
  }

  Widget counterWidget() {
    Widget subtractWidget = IconButton(
      icon: Icon(
        FontAwesomeIcons.minus,
        color: Colors.red,
      ),
      onPressed: () {
        int v = int.parse(quantityTEC.text);
        if(v > 0){
          v = v - 1;
          update(v);
        }
      },
    );

    int n = 0;
    if(quantityTEC.text.isNotEmpty){
      n = int.parse(quantityTEC.text);
    }

    Widget numTextField = Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: ( n >= 1  ? Colors.green : Colors.grey)),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          controller: quantityTEC,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          onChanged: (v) {},
          onFieldSubmitted: (v) {},
        ),
      ),
    );

    Widget addWidget = IconButton(
      icon: Icon(
        FontAwesomeIcons.plus,
        color: Colors.green,
      ),
      onPressed: () {
        int v = int.parse(quantityTEC.text);
        v = v + 1;
        update(v);
      },
    );

    Widget rowCounterWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        subtractWidget,
        Container(height: 70, width: 100, child: numTextField),
        addWidget
      ],
    );

    return (widget.userPermission.isNurse?rowCounterWidget:Container());
  }

  Widget patientConsumableNurseRow(Consumable consumable) {

    Widget consumableNameWidget = Container(
      child: Text('Name: ' + consumable.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + consumable.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text(
          'Quantity: ' + widget.patientConsumableNurse.quantity.toString()),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: ' + dateFormat()),
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
            displayCol,
            counterWidget()
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

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: displayCard,
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget currentWidget = Container();

    if(consumableModel.consumableList!=null){
      if(consumableModel.consumableList.length > 0){
        Consumable consumable = consumableModel.consumableList
            .where((element) =>
        element.id == widget.patientConsumableNurse.consumableId)
            .toList()[0];

        quantityTEC.text = widget.patientConsumableNurse.quantity.toString();
        currentWidget = patientConsumableNurseRow(consumable);
      }
    }

    return currentWidget;
  }
}
