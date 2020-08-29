import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
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
      onPressed: () {},
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
            buttonRow('Incubator'),
            buttonRow('Condition'),
            buttonRow('Analysis'),
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
