import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/editpatientlaboratoryscreen.dart';

class PatientLaboratoryRowWidget extends StatefulWidget {
  final PatientLaboratory patientLaboratory;
  PatientLaboratoryRowWidget({
    this.patientLaboratory,
  });
  @override
  _PatientLaboratoryRowWidgetState createState() =>
      _PatientLaboratoryRowWidgetState();
}

class _PatientLaboratoryRowWidgetState extends State<PatientLaboratoryRowWidget> {
  String dateFormat() {
    String v = widget.patientLaboratory.createdDate.day.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.month.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.year.toString();
    return v;
  }

  Widget patientLaboratoryRow(Laboratory laboratory) {
    Widget laboratoryNameWidget = Container(
      child: Text('Name: ' + laboratory.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + laboratory.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Result: ' + widget.patientLaboratory.result),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: ' + dateFormat()),
    );

    Widget editButtonWidget = Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Edit'),
            onPressed: () {
              patientLaboratoryModel.editPatientLaboratory(widget.patientLaboratory);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPatientLaboratoryScreen(
                    patientLaboratory: widget.patientLaboratory,
                    laboratory: laboratory,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: laboratoryNameWidget,
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
        ),
        (userPermission.isDoctor ? editButtonWidget : Container())
      ],
    );

    Widget displayCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayCol,
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

    if (laboratoryModel.laboratoryList != null) {
      if (laboratoryModel.laboratoryList.length > 0) {
        int index = laboratoryModel.laboratoryList.indexWhere(
            (element) => element.id == widget.patientLaboratory.laboratoryId);

        if (index >= 0) {
          Laboratory laboratory = laboratoryModel.laboratoryList[index];

          currentWidget = patientLaboratoryRow(laboratory);
        }
      }
    }

    return currentWidget;
  }
}
