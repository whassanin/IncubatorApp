import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/views/laboratory/laboratoryscreen/editlaboratoryscreen.dart';
import 'package:incubatorapp/views/laboratory/laboratorywebpage/editlaboratorywebpage.dart';

class LaboratoryRowWidget extends StatefulWidget {
  final Patient patient;
  final Laboratory laboratory;
  LaboratoryRowWidget({
    this.patient,
    this.laboratory,
  });
  @override
  _LaboratoryRowWidgetState createState() => _LaboratoryRowWidgetState();
}

class _LaboratoryRowWidgetState extends State<LaboratoryRowWidget> {
  bool isSelected = false;

  void navigate() {
    if (webPageModel.isWeb) {
      laboratoryModel.editLaboratory(widget.laboratory);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditLaboratoryWebPage()));
    } else {
      if (userPermission.isDoctor) {
        update();
      } else if (userPermission.isAccountant) {
        laboratoryModel.editLaboratory(widget.laboratory);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditLaboratoryScreen()));
      }
    }
  }

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


  int findLaboratory() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    patientLaboratoryModel.patientLaboratoryList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.laboratoryId == widget.laboratory.id &&
          dateFormat(element.createdDate) == dn) {
        index = patientLaboratoryModel.patientLaboratoryList.indexOf(element);
      }
    });

    return index;
  }

  void delete() {
    int index = findLaboratory();
    if (index > -1) {
      patientLaboratoryModel.editPatientLaboratory(
          patientLaboratoryModel.patientLaboratoryList[index]);
      patientLaboratoryModel.delete();
    }
  }

  void save() {
    patientLaboratoryModel.createPatientLaboratory();
    patientLaboratoryModel.setPatientId(widget.patient.userId);
    patientLaboratoryModel.setLaboratoryId(widget.laboratory.id);
    patientLaboratoryModel.create();
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
            child: Text(widget.laboratory.name,
                style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.laboratory.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
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
        navigate();
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
      index = findLaboratory();
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
