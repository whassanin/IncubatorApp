import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';

class PatientMedicineDoctorFormWidget extends StatefulWidget {
  final PatientMedicineDoctor patientMedicineDoctor;
  final Medicine medicine;
  PatientMedicineDoctorFormWidget({this.patientMedicineDoctor, this.medicine});
  @override
  _PatientMedicineDoctorFormWidgetState createState() =>
      _PatientMedicineDoctorFormWidgetState();
}

class _PatientMedicineDoctorFormWidgetState
    extends State<PatientMedicineDoctorFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController dateTEC = new TextEditingController();
  TextEditingController descriptionTEC = new TextEditingController();
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

    Widget numTextField = Expanded(
      child: Padding(
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
      children: <Widget>[subtractWidget, numTextField, addWidget],
    );

    return (userPermission.isDoctor ? rowCounterWidget : Container());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.medicine.name;
    dateTEC.text = dateFormat();
    descriptionTEC.text = widget.patientMedicineDoctor.description;
  }

  @override
  Widget build(BuildContext context) {
    quantityTEC.text = widget.patientMedicineDoctor.quantity.toString();

    Widget nameTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: nameTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Name',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget dateTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: dateTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Date',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget commentTextField = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          minLines: null,
          maxLines: null,
          expands: true,
          readOnly: userPermission.isDoctor ? false : true,
          controller: descriptionTEC,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            labelText: 'Description',
          ),
          validator: (v) {
            if (v.isEmpty) {
              return 'Required';
            }
            return null;
          },
          onChanged: (v) {
            patientMedicineDoctorModel.setDescription(v);
          },
          onFieldSubmitted: (v) {
            patientMedicineDoctorModel.setDescription(v);
          },
        ),
      ),
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
            onPressed: () {
              patientMedicineDoctorModel.delete();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              patientMedicineDoctorModel.update();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget updateButtonsWidget = Row(
      children: <Widget>[
        deleteButton,
        saveButton,
      ],
    );

    Widget rowWidget = Column(
      children: <Widget>[
        nameTextField,
        dateTextField,
        counterWidget(),
        commentTextField,
        (userPermission.isDoctor ? updateButtonsWidget : Container()),
      ],
    );

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 80,
        ),
        child: rowWidget,
      ),
    );
  }
}
