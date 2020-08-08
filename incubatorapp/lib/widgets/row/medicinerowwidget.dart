import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';

class MedicineRowWidget extends StatefulWidget {
  final Patient patient;
  final Medicine medicine;
  final UserPermission userPermission;
  MedicineRowWidget({this.patient,this.medicine, this.userPermission});
  @override
  _MedicineRowWidgetState createState() => _MedicineRowWidgetState();
}

class _MedicineRowWidgetState extends State<MedicineRowWidget> {
  bool isSelected = false;

  TextEditingController quantityTEC = new TextEditingController();

  void operation(String opType) {
    int v = int.parse(quantityTEC.text);
    if (patientMedicineDoctorModel.currentPatientMedicineDoctor != null) {
      patientMedicineDoctorModel.createPatientMedicineDoctor();
    }

    patientMedicineDoctorModel.setPatientId(widget.patient.id);
    patientMedicineDoctorModel.setMedicineId(widget.medicine.id);
    patientMedicineDoctorModel.setDoctorId(doctorModel.currentDoctor.id);

    if (opType == 'add') {
      v = v + 1;
    } else if (opType == 'subtract') {
      if (v > 0) {
        v = v - 1;
      }
    }

    quantityTEC.text = v.toString();
    patientMedicineDoctorModel.setQuantity(v);

/*    patientMedicineDoctorModel
        .addToList(patientMedicineDoctorModel.currentPatientMedicineDoctor);*/
  }

  Widget counterWidget() {
    Widget subtractWidget = IconButton(
      icon: Icon(
        FontAwesomeIcons.minus,
        color: Colors.red,
      ),
      onPressed: () {
        operation('subtract');
      },
    );

    Widget numTextField = Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: (quantityTEC.text!='0'?Colors.green:Colors.grey)
          ),
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
        operation('add');
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

    return rowCounterWidget;
  }

  Widget row() {

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
            patientMedicineDoctorModel.createPatientMedicineDoctor();
            patientMedicineDoctorModel.setPatientId(widget.patient.id);
            patientMedicineDoctorModel.setMedicineId(widget.medicine.id);
            patientMedicineDoctorModel.setDoctorId(doctorModel.currentDoctor.id);
            if (b == true) {
              patientMedicineDoctorModel.editToList(patientMedicineDoctorModel.currentPatientMedicineDoctor,'add');
            }else {
              patientMedicineDoctorModel.editToList(patientMedicineDoctorModel.currentPatientMedicineDoctor,'delete');
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
