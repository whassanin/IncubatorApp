import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/models/bill.dart';
class BillDetailRowWidget extends StatefulWidget {
  final Bill bill;

  BillDetailRowWidget({this.bill});

  @override
  _BillDetailRowWidgetState createState() => _BillDetailRowWidgetState();
}

class _BillDetailRowWidgetState extends State<BillDetailRowWidget> {

  Widget rowDetailData(String title,String val){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide.none,
          left: BorderSide(width: 1, color: Colors.black),
          bottom: BorderSide(width: 1, color: Colors.black),
          right: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                child: Text(title,style: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                child: Text(val,style: TextStyle(fontSize: 12),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowTitle(String title){
    Widget containerTitle = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide.none,
          left: BorderSide(width: 1, color: Colors.black),
          bottom: BorderSide(width: 1, color: Colors.black),
          right: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      height: 70,
      child: Center(
        child: Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
    );
    return containerTitle;
  }

  @override
  Widget build(BuildContext context) {



    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          rowTitle('Basic'),
          rowDetailData('Day Cost',widget.bill.dayCost.toString()),
          rowDetailData('Staying',widget.bill.staying.toString()),
          rowDetailData('Cleaning',widget.bill.incubatorClean.toString()),
          rowDetailData('Consumable',widget.bill.consumable.toString()),
          rowDetailData('Analysis',widget.bill.analysis.toString()),
          rowDetailData('XRay',widget.bill.xRay.toString()),
          rowDetailData('Light Ray',widget.bill.lightRays.toString()),
          rowDetailData('Medicine',widget.bill.medicine.toString()),
          rowTitle('Extra')
        ],
      ),
    );
  }
}
