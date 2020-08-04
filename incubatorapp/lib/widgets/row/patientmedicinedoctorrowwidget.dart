import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';

class PatientMedicineDoctorRowWidget extends StatefulWidget {
  final PatientMedicineDoctor patientMedicineDoctor;
  PatientMedicineDoctorRowWidget({this.patientMedicineDoctor});
  @override
  _PatientMedicineDoctorRowWidgetState createState() =>
      _PatientMedicineDoctorRowWidgetState();
}

class _PatientMedicineDoctorRowWidgetState extends State<PatientMedicineDoctorRowWidget> {

  Widget patientMedicineDoctorRow() {
    Medicine medicine = medicineModel.medicineList
        .where((element) => element.id == widget.patientMedicineDoctor.medicineId)
        .toList()[0];

    Widget medicineNameWidget = Container(
      child: Text('Name: '+medicine.name+': '+medicine.price.toString()),
    );

    Widget resultWidget = Container(
      child: Text('Quantity: '+widget.patientMedicineDoctor.quantity.toString()),
    );

    Widget createdDateWidget = Container(
      child: Text('Date: '+widget.patientMedicineDoctor.createdDate.toLocal().toString()),
    );

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: medicineNameWidget,
        ),
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
    return patientMedicineDoctorRow();
  }
}
