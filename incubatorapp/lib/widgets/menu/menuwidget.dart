import 'package:flutter/material.dart';
import 'package:incubatorapp/screens/conditionscreen/conditionscreen.dart';
import 'package:incubatorapp/screens/consumablescreen/consumablescreen.dart';
import 'package:incubatorapp/screens/extrascreen/extrascreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/incubatorscreen.dart';
import 'package:incubatorapp/screens/laboratoryscreen/laboratoryscreen.dart';
import 'package:incubatorapp/screens/medicinescreen/medicinescreen.dart';
import 'package:incubatorapp/screens/shiftscreen/shiftscreen.dart';
import 'package:incubatorapp/screens/xrayscreen/xrayscreen.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  void navigateToIncubator(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>IncubatorScreen(false)));
  }

  void navigateToCondition(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConditionScreen(false)));
  }

  void navigateToLaboratory(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LaboratoryScreen()));
  }

  void navigateToMedicine(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineScreen()));
  }

  void navigateToConsumable(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConsumableScreen()));
  }

  void navigateToXRay(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>XRayScreen()));
  }

  void navigateToExtra(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ExtraScreen()));
  }

  void navigateToShift(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShiftScreen()));
  }

  Widget buttonRow(String title, {VoidCallback fun}) {
    Widget clickButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      )),
      color: Colors.cyan,
      child: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: 18),
      ),
      onPressed: () {
        if(fun!=null){
          fun();
        }
      },
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: rowButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonRow('Incubator',fun: navigateToIncubator),
            buttonRow('Condition',fun: navigateToCondition),
            buttonRow('Laboratory',fun: navigateToLaboratory),
            buttonRow('Medicine',fun: navigateToMedicine),
            buttonRow('Consumable',fun: navigateToConsumable),
            buttonRow('XRay',fun: navigateToXRay),
            buttonRow('Extra',fun: navigateToExtra),
            buttonRow('Shift Hours',fun: navigateToShift),
          ],
        ),
      ),
    );
  }
}
