import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/medicinerowwidget.dart';

class MedicineListWidget extends StatefulWidget {
  final Patient patient;
  final List<Medicine> medicineList;
  final UserPermission userPermission;
  MedicineListWidget({this.patient, this.medicineList, this.userPermission});

  @override
  _MedicineListWidgetState createState() => _MedicineListWidgetState();
}

class _MedicineListWidgetState extends State<MedicineListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.medicineList != null) {
      if (widget.medicineList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.medicineList.length,
          itemBuilder: (BuildContext context, int index) {
            return MedicineRowWidget(
              patient: widget.patient,
              medicine: widget.medicineList[index],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Medicine(s) Available'),
          ),
        );
      }
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = _getList();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: _getList()));

    Widget positionSaveButton = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {
            patientMedicineDoctorModel.readByPatientId();
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (widget.userPermission.isDoctor) {
      currentWidget = Stack(
        children: <Widget>[positionList, positionSaveButton],
      );
    }

    return currentWidget;
  }
}