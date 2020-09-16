import 'package:flutter/material.dart';
import 'package:huawei_push/push.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/extra.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/extrascreen/editextrascreen.dart';

class ExtraRowWidget extends StatefulWidget {
  final Patient patient;
  final Extra extra;
  ExtraRowWidget({
    this.patient,
    this.extra,
  });
  @override
  _ExtraRowWidgetState createState() => _ExtraRowWidgetState();
}

class _ExtraRowWidgetState extends State<ExtraRowWidget> {
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

  void navigateToEditExtraScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditExtraScreen()));
  }

  int findExtra() {
    String dn = dateFormat(DateTime.now());

    int index = -1;

    patientExtraModel.patientExtraList.forEach((element) {
      if (element.patientId == widget.patient.userId &&
          element.extraId == widget.extra.id &&
          dateFormat(element.createdDate) == dn) {
        index = patientExtraModel.patientExtraList.indexOf(element);
      }
    });

    return index;
  }

  void delete() {
    int index = findExtra();
    patientExtraModel
        .editPatientExtra(patientExtraModel.patientExtraList[index]);
    patientExtraModel.delete();
  }

  void save() async {
    patientExtraModel.createPatientExtra();
    patientExtraModel.setPatientId(widget.patient.userId);
    patientExtraModel.setExtraId(widget.extra.id);
    patientExtraModel.create();
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
            child: Text(widget.extra.name, style: TextStyle(color: textColor)),
          ),
        ),
        (userPermission.isAccountant
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Price: ' + widget.extra.price.toString(),
                      style: TextStyle(color: textColor)),
                ),
              )
            : Container()),
      ],
    );

    Widget deleteButton = RaisedButton(
      child: Text('Delete'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      onPressed: (){
        delete();
      },
    );

    Widget rowContainer = Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: rowData,
      ),
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
        if (userPermission.isDoctor || userPermission.isNurse) {
          update();
        } else if (userPermission.isAccountant) {
          extraModel.editExtra(widget.extra);
          navigateToEditExtraScreen();
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
      index = findExtra();

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
