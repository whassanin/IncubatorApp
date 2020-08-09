import 'package:flutter/material.dart';
import 'package:incubatorapp/models/status.dart';
class StatusRowWidget extends StatefulWidget {
  final Status status;
  StatusRowWidget({this.status});
  @override
  _StatusRowWidgetState createState() => _StatusRowWidgetState();
}

class _StatusRowWidgetState extends State<StatusRowWidget> {

  Widget rowSubData(String title,String val){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(child: Text(title)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(child: Text(val)),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowTile(){

    String v = widget.status.createdDate.day.toString();
    v = v + '/' + widget.status.createdDate.month.toString();
    v = v + '/' + widget.status.createdDate.year.toString();

    return ExpansionTile(
      title: Text(v),
      children: <Widget>[
        rowSubData('Heart Rate:',widget.status.heartRate.toString()),
        rowSubData('Pulse Rate:',widget.status.pulseRate.toString()),
        rowSubData('oxygen:',widget.status.oxygen.toString()),
        rowSubData('Weight:',widget.status.weight.toString()),
        rowSubData('Sugar:',widget.status.sugar.toString()),
        rowSubData('Urine:',widget.status.urine.toString()),
        rowSubData('Stool:',widget.status.stool.toString()),
        rowSubData('Blood Pressure:',widget.status.bloodPressure.toString()),
        rowSubData('Temperature:',widget.status.temperature.toString()),
        rowSubData('Incubator Temperature:',widget.status.incubatorTemperature.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return rowTile();
  }
}
