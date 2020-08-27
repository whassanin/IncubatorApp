import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';

class MedicineRowWidget extends StatefulWidget {
  final Patient patient;
  final Medicine medicine;
  final UserPermission userPermission;
  MedicineRowWidget({this.patient, this.medicine, this.userPermission});
  @override
  _MedicineRowWidgetState createState() => _MedicineRowWidgetState();
}

class _MedicineRowWidgetState extends State<MedicineRowWidget> {
  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void update() {
    int index = findMedicine();
    if (index >= 0) {
      delete(index);
    } else if (index < 0) {
      save();
    }
  }

  int findMedicine() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    patientMedicineDoctorModel.patientMedicineDoctorList.forEach((element) {
      if(element.patientId == widget.patient.userId &&
          element.medicineId == widget.medicine.id &&
          element.doctorId == doctorModel.currentDoctor.userId){
        index = patientMedicineDoctorModel.patientMedicineDoctorList.indexOf(element);
      }
    });

    return index;
  }

  void delete(int index) {
    patientMedicineDoctorModel.editPatientMedicineDoctor(
        patientMedicineDoctorModel.patientMedicineDoctorList[index]);
    patientMedicineDoctorModel.delete();
  }

  void save() {
    patientMedicineDoctorModel.createPatientMedicineDoctor();
    patientMedicineDoctorModel.setPatientId(widget.patient.userId);
    patientMedicineDoctorModel.setMedicineId(widget.medicine.id);
    patientMedicineDoctorModel.setDoctorId(doctorModel.currentDoctor.userId);
    patientMedicineDoctorModel.setQuantity(1);
    patientMedicineDoctorModel.create();
  }

  Widget row() {

    int index = findMedicine();

    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if(index >= 0){
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.medicine.id.toString(),style: TextStyle(color: textColor),),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.medicine.name,
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
        if (widget.userPermission.isDoctor) {
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
