import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/screens/medicinescreen/editmedicinescreen.dart';

class MedicineRowWidget extends StatefulWidget {
  final Patient patient;
  final Medicine medicine;
  MedicineRowWidget({
    this.patient,
    this.medicine,
  });
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

  void update() {
    if (isSelected) {
      isSelected = false;
      delete();
    } else {
      isSelected = true;
      save();
    }
  }

  void navigateToEditMedicineScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditMedicineScreen()));
  }

  int findMedicine() {
    String dn = dateFormat(DateTime.now());
    int index = -1;

    patientMedicineDoctorModel.patientMedicineDoctorList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.medicineId == widget.medicine.id &&
          element.doctorId == doctorModel.currentDoctor.userId &&
          dateFormat(element.createdDate) == dn) {
        index = patientMedicineDoctorModel.patientMedicineDoctorList
            .indexOf(element);
      }
    });

    return index;
  }

  void delete() {
    int index = findMedicine();
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
    Color cardColor = Colors.white;
    Color textColor = Colors.black;

    if (isSelected) {
      cardColor = Colors.purpleAccent;
      textColor = Colors.white;
    }

    Widget rowData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child:
                Text(widget.medicine.name, style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.medicine.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Amount: ' + widget.medicine.amount.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
      ],
    );

    Widget rowContainer = Container(
      height: (userPermission.isDoctor ? 70 : 98),
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
        if (userPermission.isDoctor) {
          update();
        } else if (userPermission.isAccountant) {
          medicineModel.editMedicine(widget.medicine);
          navigateToEditMedicineScreen();
        }
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
    int index = -1;
    if (widget.patient != null) {
      index = findMedicine();

      if (index > -1) {
        isSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
