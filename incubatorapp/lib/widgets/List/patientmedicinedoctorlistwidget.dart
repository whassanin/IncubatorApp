import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/widgets/row/patientmedicinedoctorrowwidget.dart';

class PatientMedicineDoctorListWidget extends StatefulWidget {
  final List<PatientMedicineDoctor> patientMedicineDoctorList;
  PatientMedicineDoctorListWidget({
    this.patientMedicineDoctorList,
  });

  @override
  _PatientMedicineDoctorListWidgetState createState() =>
      _PatientMedicineDoctorListWidgetState();
}

class _PatientMedicineDoctorListWidgetState
    extends State<PatientMedicineDoctorListWidget> {
  List<PatientMedicineDoctor> addCalculatedList = [];

  double calculate() {
    double total = 0;
    if (widget.patientMedicineDoctorList != null) {
      if (widget.patientMedicineDoctorList.length > 0) {
        widget.patientMedicineDoctorList.forEach((pmd) {
          int index = addCalculatedList.indexOf(pmd);

          if (index < 0) {
            int im = medicineModel.medicineList
                .indexWhere((a) => a.id == pmd.medicineId);

            if (im >= 0) {
              Medicine medicine = medicineModel.medicineList[im];
              total += (medicine.price * pmd.quantity);
            }
          }
        });
      }
    }
    return total;
  }

  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.patientMedicineDoctorList != null) {
      if (widget.patientMedicineDoctorList.length > 0) {
        if (patientMedicineDoctorModel.isAdding == false) {
          currentWidget = ListView.builder(
            itemCount: widget.patientMedicineDoctorList.length,
            itemBuilder: (BuildContext context, int i) {
              return PatientMedicineDoctorRowWidget(
                patientMedicineDoctor: widget.patientMedicineDoctorList[i],
              );
            },
          );
        }
      } else {
        if (patientMedicineDoctorModel.isAdding == false) {
          currentWidget = Center(
            child: Container(
              child: Text('No Medicine(s) Available'),
            ),
          );
        }
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('Loading...'),
        ),
      );
    }

    if (userPermission.isPatient) {
      currentWidget = Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: currentWidget,
      );
    }

    return currentWidget;
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = getList();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: getList()));

    Widget positionTotal = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Text(
              'Total: ' + calculate().toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );

    if (userPermission.isPatient) {
      calculate();
      currentWidget = Stack(
        children: <Widget>[positionList, positionTotal],
      );
    }

    return currentWidget;
  }
}
