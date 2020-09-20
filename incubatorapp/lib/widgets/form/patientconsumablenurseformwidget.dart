import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';

class PatientConsumableNurseFormWidget extends StatefulWidget {
  final PatientConsumableNurse patientConsumableNurse;
  final Consumable consumable;
  PatientConsumableNurseFormWidget({this.patientConsumableNurse, this.consumable});
  @override
  _PatientConsumableNurseFormWidgetState createState() => _PatientConsumableNurseFormWidgetState();
}

class _PatientConsumableNurseFormWidgetState extends State<PatientConsumableNurseFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController dateTEC = new TextEditingController();
  TextEditingController quantityTEC = new TextEditingController();

  String dateFormat() {
    String v = widget.patientConsumableNurse.createdDate.day.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.month.toString();
    v = v + '/' + widget.patientConsumableNurse.createdDate.year.toString();
    return v;
  }

  void update(int v) {
    patientConsumableNurseModel
        .editPatientConsumableNurse(widget.patientConsumableNurse);
    if (v == 0) {
      patientConsumableNurseModel.delete();
    } else {
      patientConsumableNurseModel.setQuantity(v);
      patientConsumableNurseModel.update();
    }
  }

  Widget counterWidget() {
    Widget subtractWidget = IconButton(
      icon: Icon(
        FontAwesomeIcons.minus,
        color: Colors.red,
      ),
      onPressed: () {
        int v = int.parse(quantityTEC.text);
        if (v > 0) {
          v = v - 1;
          update(v);
        }
      },
    );

    int n = 0;
    if (quantityTEC.text.isNotEmpty) {
      n = int.parse(quantityTEC.text);
    }

    Widget numTextField = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: (n >= 1 ? Colors.green : Colors.grey)),
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

    Widget rowCounterWidget = Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          subtractWidget,
          numTextField,
          addWidget
        ],
      ),
    );

    return (userPermission.isNurse ? rowCounterWidget : Container());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.consumable.name;
    dateTEC.text = dateFormat();
  }

  @override
  Widget build(BuildContext context) {

    quantityTEC.text = widget.patientConsumableNurse.quantity.toString();

    Widget nameTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: nameTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Name',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget dateTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: dateTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Date',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Delete',style: TextStyle(color: Colors.white)),
            onPressed: () {
              patientConsumableNurseModel.delete();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Save',style: TextStyle(color: Colors.white),),
            onPressed: () {
              patientConsumableNurseModel.update();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget updateButtonsWidget = Row(
      children: <Widget>[
        deleteButton,
        saveButton,
      ],
    );

    Widget rowWidget = Column(
      children: <Widget>[
        nameTextField,
        dateTextField,
        counterWidget(),
        (userPermission.isNurse?updateButtonsWidget:Container()),
      ],
    );

    return rowWidget;
  }
}
