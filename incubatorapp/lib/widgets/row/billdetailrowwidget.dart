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
  Widget rowTitle(String title) {
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
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return containerTitle;
  }

  Widget rowDetailData(String title, String val) {
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
                child: Text(title, style: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                child: Text(
                  val,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowBillExtraList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.bill.billExtraList.length,
      itemBuilder: (BuildContext context, int i) {
        String name = widget.bill.billExtraList[i].name;
        String val = widget.bill.billExtraList[i].cost.toString();
        return rowDetailData(name, val);
      },
    );
  }

  Widget rowFooterData(String title, String val) {
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
                child: Text(title, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                child: Text(
                  val,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0;

    double sum = widget.bill.dayCost +
        widget.bill.staying +
        widget.bill.incubatorClean +
        widget.bill.consumable +
        widget.bill.analysis +
        widget.bill.xRay +
        widget.bill.lightRays +
        widget.bill.medicine;

    if(widget.bill.billExtraList!=null){
      if(widget.bill.billExtraList.length > 0){
        widget.bill.billExtraList.forEach((be) {
          sum+=be.cost;
        });
      }
    }

    total += sum;

    return total;
  }

  double calculateChange() {
    return widget.bill.paid - calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          rowTitle('Basic'),
          rowDetailData('Day Cost', widget.bill.dayCost.toString()),
          rowDetailData('Staying', widget.bill.staying.toString()),
          rowDetailData('Cleaning', widget.bill.incubatorClean.toString()),
          rowDetailData('Consumable', widget.bill.consumable.toString()),
          rowDetailData('Analysis', widget.bill.analysis.toString()),
          rowDetailData('XRay', widget.bill.xRay.toString()),
          rowDetailData('Light Ray', widget.bill.lightRays.toString()),
          rowDetailData('Medicine', widget.bill.medicine.toString()),
          rowTitle('Extra'),
          rowBillExtraList(),
          rowTitle('Total Payment'),
          rowFooterData('Total', calculateTotal().toString()),
          rowFooterData('Paid', widget.bill.paid.toString()),
          rowFooterData('Change', calculateChange().toString()),
        ],
      ),
    );
  }
}
