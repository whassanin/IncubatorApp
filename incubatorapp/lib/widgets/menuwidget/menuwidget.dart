import 'package:flutter/material.dart';
import 'package:incubatorapp/screens/analysisscreen/analysisscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/incubatorscreen.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  void navigateToIncubator(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>IncubatorScreen()));
  }

  void navigateToAnalysis(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalysisScreen()));
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
            buttonRow('Condition'),
            buttonRow('Analysis',fun: navigateToAnalysis),
            buttonRow('Medicine'),
            buttonRow('Consumable'),
            buttonRow('XRay'),
            buttonRow('Shift Hours'),
          ],
        ),
      ),
    );
  }
}
