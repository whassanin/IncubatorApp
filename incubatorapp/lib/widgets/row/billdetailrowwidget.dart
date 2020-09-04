import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/patientextra.dart';

class BillDetailRowWidget extends StatefulWidget {
  final Bill bill;
  final List<PatientExtra> patientExtraList;
  BillDetailRowWidget(this.bill, this.patientExtraList);

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
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.patientExtraList != null) {
      if (widget.patientExtraList.length > 0) {
        currentWidget = ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: widget.patientExtraList.length,
          itemBuilder: (BuildContext context, int i) {
            int index = extraModel.extraList.indexWhere(
                (element) => element.id == widget.patientExtraList[i].extraId);
            String name = extraModel.extraList[index].name;
            String val = extraModel.extraList[index].price.toString();
            return rowDetailData(name, val);
          },
        );
      } else {
        currentWidget = rowTitle('No Extra Bills');
      }
    } else {
      currentWidget = rowTitle('No Extra Bills');
    }

    return currentWidget;
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
                child: Text(title,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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

  double calculateChange() {
    return widget.bill.paid -  billModel.calculateBillRow(widget.bill);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          rowTitle('Basic'),
          rowDetailData('Day Cost', widget.bill.dayCost.toString()),
          rowDetailData('Consumable', widget.bill.consumable.toString()),
          rowDetailData('Analysis', widget.bill.analysis.toString()),
          rowDetailData('XRay', widget.bill.xRay.toString()),
          rowDetailData('Light Ray', widget.bill.lightRays.toString()),
          rowDetailData('Medicine', widget.bill.medicine.toString()),
          rowTitle('Extra'),
          rowBillExtraList(),
          rowTitle('Total Payment'),
          rowFooterData('Total', billModel.calculateBillRow(widget.bill).toString()),
          rowFooterData('Paid', widget.bill.paid.toString()),
          rowFooterData('Change', calculateChange().toString()),
        ],
      ),
    );
  }
}
