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

  Widget displayRow(String title, String val) {
    return Row(
      children: [
        Container(
          child: Text(title),
          width: 50,
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

  String dateFormat() {
    String v = widget.patientLaboratory.createdDate.day.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.month.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.year.toString();
    return v;
  }

  Widget patientLaboratoryRow(Laboratory laboratory) {
    Widget laboratoryNameWidget =displayRow('Name:', laboratory.name);

    Widget priceWidget = displayRow('Price:', laboratory.price.toString());

    Widget resultWidget = displayRow('Result:', widget.patientLaboratory.result);

    Widget createdDateWidget = displayRow('Date:', dateFormat());

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: laboratoryNameWidget,
        ),
        (userPermission.isPatient
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: priceWidget,
              )
            : Container()),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: createdDateWidget,
        ),
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

    Widget cardGesture = GestureDetector(
      child: displayCard,
      onTap: (){
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
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: cardGesture,
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
