import 'package:flutter/material.dart';
import 'package:incubatorapp/models/incubator.dart';

class IncubatorRowWidget extends StatefulWidget {
  final Incubator incubator;
  IncubatorRowWidget({this.incubator});
  @override
  _IncubatorRowWidgetState createState() => _IncubatorRowWidgetState();
}

class _IncubatorRowWidgetState extends State<IncubatorRowWidget> {

  Widget row(){

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.incubator.id.toString()),
        SizedBox(
          width: 10,
        ),
        Text('Company Name: ' + widget.incubator.name),
      ],
    );

    Widget rowContainer = Container(
      height: 50,
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: rowData
      ),
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

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
      child: rowCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
