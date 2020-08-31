import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'file:///C:/Users/Waleed%20Hassanin/Documents/GitHub/IncubatorApp/incubatorapp/lib/screens/patientmedicinedoctorscreen/editpatientmedicinedoctorscreen.dart';

class PatientMedicineDoctorRowWidget extends StatefulWidget {
  final PatientMedicineDoctor patientMedicineDoctor;
  PatientMedicineDoctorRowWidget(
      {this.patientMedicineDoctor,});
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

  Widget patientMedicineDoctorRow(Medicine medicine) {
    Widget medicineNameWidget = Container(
      child: Text('Name: ' + medicine.name),
    );

    Widget priceWidget = Container(
      child: Text('Price: ' + medicine.price.toString()),
    );

    Widget resultWidget = Container(
      child:
          Text('Quantity: ' + widget.patientMedicineDoctor.quantity.toString()),
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
            child: Text(userPermission.isDoctor ? 'Edit' : 'View Description'),
            onPressed: () {
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
              children: <Widget>[displayCol, counterWidget()],
            ),
            ((userPermission.isDoctor || userPermission.isNurse)
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Container();

    if (medicineModel.medicineList != null) {
      if (medicineModel.medicineList.length > 0) {
        Medicine medicine = medicineModel.medicineList
            .where((element) =>
                element.id == widget.patientMedicineDoctor.medicineId)
            .toList()[0];

        quantityTEC.text = widget.patientMedicineDoctor.quantity.toString();
        currentWidget = patientMedicineDoctorRow(medicine);
      }
    }
    return currentWidget;
  }
}
