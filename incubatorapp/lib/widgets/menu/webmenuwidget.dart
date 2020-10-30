import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/views/condition/conditionwebpage/conditionwebpage.dart';
import 'package:incubatorapp/views/consumable/consumablescreen/consumablescreen.dart';
import 'package:incubatorapp/views/extra/extrascreen/extrascreen.dart';
import 'package:incubatorapp/views/incubator/incubatorwebpage/incubatorwebpage.dart';
import 'package:incubatorapp/views/laboratory/laboratorywebpage/laboratorywebpage.dart';
import 'package:incubatorapp/views/medicine/medicinescreen/medicinescreen.dart';
import 'package:incubatorapp/views/medicine/medicinewebpage/medicinewebpage.dart';
import 'package:incubatorapp/views/shift/shiftscreen/shiftscreen.dart';
import 'package:incubatorapp/views/xray/xrayscreen/xrayscreen.dart';

class WebMenuWidget extends StatefulWidget {
  @override
  _WebMenuWidgetState createState() => _WebMenuWidgetState();
}

class _WebMenuWidgetState extends State<WebMenuWidget> {
  void navigateToPatientList() {
    /*Navigator.push(context,
        MaterialPageRoute(builder: (context) => PatientListScreen()));*/
  }

  void navigateToIncubator() {
    webPageModel.setCurrentPage(IncubatorWebPage());
  }

  void navigateToCondition() {
    webPageModel.setCurrentPage(ConditionWebPage());
  }

  void navigateToLaboratory() {
    webPageModel.setCurrentPage(LaboratoryWebPage());
  }

  void navigateToMedicine() {
    webPageModel.setCurrentPage(MedicineWebPage());
  }

  void navigateToConsumable() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConsumableScreen()));
  }

  void navigateToXRay() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => XRayScreen()));
  }

  void navigateToExtra() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ExtraScreen()));
  }

  void navigateToShift() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShiftScreen()));
  }

  Widget buttonRow(String title, {VoidCallback fun}) {

    Widget clickButton = Container(
      color: Colors.cyan,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18,),
        ),
      ),
    );

    Widget containerButton = Container(
      height: 60,
      child: clickButton,
    );

    Widget rowButton = Row(
      children: <Widget>[
        Expanded(
          child: containerButton,
        )
      ],
    );

    return GestureDetector(
      onTap: (){
        if (fun != null) {
          fun();
        }
      },
      child: rowButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buttonRow('Patient', fun: navigateToIncubator),
          buttonRow('Incubator', fun: navigateToIncubator),
          buttonRow('Condition', fun: navigateToCondition),
          buttonRow('Laboratory', fun: navigateToLaboratory),
          buttonRow('Medicine', fun: navigateToMedicine),
          buttonRow('Consumable', fun: navigateToConsumable),
          buttonRow('XRay', fun: navigateToXRay),
          buttonRow('Extra', fun: navigateToExtra),
          buttonRow('Shift Hours', fun: navigateToShift),
        ],
      ),
    );
  }
}
