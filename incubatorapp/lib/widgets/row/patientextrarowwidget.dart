import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/extra.dart';
import 'package:incubatorapp/models/patientextra.dart';

class PatientExtraRowWidget extends StatefulWidget {
  final PatientExtra patientExtra;
  PatientExtraRowWidget({
    this.patientExtra,
  });
  @override
  _PatientExtraRowWidgetState createState() => _PatientExtraRowWidgetState();
}

class _PatientExtraRowWidgetState extends State<PatientExtraRowWidget> {
  String dateFormat() {
    String v = widget.patientExtra.createdDate.day.toString();
    v = v + '/' + widget.patientExtra.createdDate.month.toString();
    v = v + '/' + widget.patientExtra.createdDate.year.toString();
    return v;
  }

  Widget patientExtraRow(Extra extra) {
    Widget extraNameWidget = Container(
      child: Text('Name: ' + extra.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + extra.price.toString()),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: ' + dateFormat()),
    );

    Widget editButtonWidget = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Text('Delete',style: TextStyle(color: Colors.white),),
      color: Colors.red,
      onPressed: () {
        patientExtraModel.editPatientExtra(widget.patientExtra);
        patientExtraModel.delete();
      },
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: extraNameWidget,
        ),
        (userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: priceWidget,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: createdDateWidget,
        ),
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayCol,
            (userPermission.isDoctor || userPermission.isNurse
                ? editButtonWidget
                : Container())
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
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
    Widget currentWidget = Container();

    if (extraModel.extraList != null) {
      if (extraModel.extraList.length > 0) {
        Extra extra = extraModel.extraList
            .where((element) => element.id == widget.patientExtra.extraId)
            .toList()[0];

        currentWidget = patientExtraRow(extra);
      }
    }

    return currentWidget;
  }
}
