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
  bool isSelected = false;

  String dateFormat(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();
    return v;
  }

  void validate() {
    String dn = dateFormat(DateTime.now());

    int i = patientMedicineDoctorModel.patientMedicineDoctorList.indexWhere(
        (element) =>
            element.patientId == widget.patient.userId &&
            element.medicineId == widget.medicine.id &&
            element.doctorId == doctorModel.currentDoctor.userId &&
            dateFormat(element.createdDate) == dn);
    if (i >= 0) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  void save() {
    patientMedicineDoctorModel.createPatientMedicineDoctor();
    patientMedicineDoctorModel.setPatientId(widget.patient.userId);
    patientMedicineDoctorModel.setMedicineId(widget.medicine.id);
    patientMedicineDoctorModel.setDoctorId(doctorModel.currentDoctor.userId);
    patientMedicineDoctorModel.setQuantity(1);
    patientMedicineDoctorModel.create();
  }

  void delete() {
    String dn = dateFormat(DateTime.now());

    patientMedicineDoctorModel.createPatientMedicineDoctor();
    patientMedicineDoctorModel.setPatientId(widget.patient.userId);
    patientMedicineDoctorModel.setMedicineId(widget.medicine.id);
    patientMedicineDoctorModel.setDoctorId(doctorModel.currentDoctor.userId);

    int i = patientMedicineDoctorModel.patientMedicineDoctorList.indexWhere(
            (element) =>
        element.patientId == widget.patient.userId &&
            element.medicineId == widget.medicine.id &&
            element.doctorId == doctorModel.currentDoctor.userId &&
            dateFormat(element.createdDate) == dn);

    if(i >= 0){
      isSelected = true;
      patientMedicineDoctorModel.editPatientMedicineDoctor(patientMedicineDoctorModel.patientMedicineDoctorList[i]);
      patientMedicineDoctorModel.delete();
    }

  }

  Widget row() {
    validate();

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.medicine.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              'Name: ' + widget.medicine.name,
            ),
          ),
        ),
        (widget.userPermission.isDoctor
            ? Checkbox(
                value: isSelected,
                onChanged: (b) {
                  isSelected = b;
                  if (b == true) {
                    save();
                  } else {
                    delete();
                  }
                },
              )
            : Container())
      ],
    );

    Widget rowContainer = Container(
      height: 70,
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
