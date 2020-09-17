import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';

class PatientMedicineDoctorFormWidget extends StatefulWidget {
  final PatientMedicineDoctor patientMedicineDoctor;
  final Medicine medicine;
  PatientMedicineDoctorFormWidget({this.patientMedicineDoctor, this.medicine});
  @override
  _PatientMedicineDoctorFormWidgetState createState() => _PatientMedicineDoctorFormWidgetState();
}

class _PatientMedicineDoctorFormWidgetState extends State<PatientMedicineDoctorFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController descriptionTEC = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.medicine.name;
    descriptionTEC.text = widget.patientMedicineDoctor.description;

  }

  @override
  Widget build(BuildContext context) {
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
                labelText: 'MedicineDoctor Name',
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
          readOnly: userPermission.isDoctor?false:true,
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
            if(v.isEmpty){
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
            child: Text('Delete',style: TextStyle(color: Colors.white)),
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
            child: Text('Save',style: TextStyle(color: Colors.white),),
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
        commentTextField,
        (userPermission.isDoctor?updateButtonsWidget:Container()),
      ],
    );

    return rowWidget;
  }
}
