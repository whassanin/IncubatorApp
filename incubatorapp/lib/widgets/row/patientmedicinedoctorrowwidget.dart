import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/screens/patientmedicinedoctorscreen/editpatientmedicinedoctorscreen.dart';

class PatientMedicineDoctorRowWidget extends StatefulWidget {
  final PatientMedicineDoctor patientMedicineDoctor;
  PatientMedicineDoctorRowWidget({
    this.patientMedicineDoctor,
  });
  @override
  _PatientMedicineDoctorRowWidgetState createState() =>
      _PatientMedicineDoctorRowWidgetState();
}

class _PatientMedicineDoctorRowWidgetState
    extends State<PatientMedicineDoctorRowWidget> {
  TextEditingController quantityTEC = new TextEditingController();

  String dateFormat() {
    String v = widget.patientMedicineDoctor.createdDate.day.toString();
    v = v + '/' + widget.patientMedicineDoctor.createdDate.month.toString();
    v = v + '/' + widget.patientMedicineDoctor.createdDate.year.toString();
    return v;
  }

  void update(int v) {
    patientMedicineDoctorModel
        .editPatientMedicineDoctor(widget.patientMedicineDoctor);

    if (v == 0) {
      patientMedicineDoctorModel.delete();
    } else {
      patientMedicineDoctorModel.setQuantity(v);
      patientMedicineDoctorModel.update();
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

    Widget numTextField = Padding(
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

    Widget rowCounterWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        subtractWidget,
        Container(height: 70, width: 100, child: numTextField),
        addWidget
      ],
    );

    return (userPermission.isDoctor ? rowCounterWidget : Container());
  }

  Widget displayRow(String title, String val) {
    return Row(
      children: [
        Container(child: Text(title), width: 70),
        Container(
          child: Text(
            val,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget patientMedicineDoctorRow(Medicine medicine) {
    String title = 'Name: ' + medicine.name;

    Widget medicineNameWidget = displayRow('Name:', medicine.name);

    Widget priceWidget = displayRow('Price:', medicine.price.toString());

    Widget resultWidget = displayRow(
        'Quantity:', widget.patientMedicineDoctor.quantity.toString());

    Widget createdDateWidget = displayRow('Date:', dateFormat());

    Widget displayCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: medicineNameWidget,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: resultWidget,
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                displayCol, /*counterWidget()*/
              ],
            ),
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

    Widget cardGesture = GestureDetector(
      child: displayCard,
      onTap: () {
        if (userPermission.isDoctor || userPermission.isNurse) {
          patientMedicineDoctorModel
              .editPatientMedicineDoctor(widget.patientMedicineDoctor);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPatientMedicineDoctorScreen(
                patientMedicineDoctor: widget.patientMedicineDoctor,
                medicine: medicine,
              ),
            ),
          );
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: cardGesture,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Container();

    if (medicineModel.medicineList != null) {
      if (medicineModel.medicineList.length > 0) {
        int index = medicineModel.medicineList.indexWhere(
            (element) => element.id == widget.patientMedicineDoctor.medicineId);

        if (index >= 0) {
          Medicine medicine = medicineModel.medicineList[index];

          quantityTEC.text = widget.patientMedicineDoctor.quantity.toString();
          currentWidget = patientMedicineDoctorRow(medicine);
        }
      }
    }
    return currentWidget;
  }
}
