import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/patientextra.dart';
import 'package:incubatorapp/screens/billscreen/editbillscreen.dart';

class BillDetailRowWidget extends StatefulWidget {
  final Bill bill;
  final List<PatientExtra> patientExtraList;
  BillDetailRowWidget(this.bill, this.patientExtraList);

  @override
  _BillDetailRowWidgetState createState() => _BillDetailRowWidgetState();
}

class _BillDetailRowWidgetState extends State<BillDetailRowWidget> {

  double calculateChange() {
    return widget.bill.paid - billModel.calculateBillRowWithDiscount();
  }

  void navigateToEditBillScreen(){
    billModel.editBill(widget.bill);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBillScreen()));
  }

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
            String d1 = billModel.formatDate(widget.bill.createdDate);
            String d2 =
                billModel.formatDate(widget.patientExtraList[i].createdDate);
            if (d1 == d2) {
              int index = extraModel.extraList.indexWhere((element) =>
                  element.id == widget.patientExtraList[i].extraId);
              String name = extraModel.extraList[index].name;
              String val = extraModel.extraList[index].price.toString();
              return rowDetailData(name, val);
            }
            return Container();
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
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
      ),
    );
  }

  Widget editButtons(String title, Color color, {VoidCallback fun}) {
    Widget button = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 60,
              child: RaisedButton(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (fun != null) {
                    fun();
                  }
                },
              ),
            ),
          ),
        )
      ],
    );

    return button;
  }

  @override
  Widget build(BuildContext context) {
    Widget navigateButton = editButtons(
      'Edit',
      Colors.cyan,
      fun: navigateToEditBillScreen
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          rowTitle('Basic'),
          rowDetailData('Day Cost', widget.bill.dayCost.toString()),
          rowDetailData('Consumable', widget.bill.consumable.toString()),
          rowDetailData('Laboratory', widget.bill.laboratory.toString()),
          rowDetailData('XRay', widget.bill.xRay.toString()),
          rowDetailData('Light Ray', widget.bill.lightRays.toString()),
          rowDetailData('Medicine', widget.bill.medicine.toString()),
          rowTitle('Extra'),
          rowBillExtraList(),
          rowTitle('Total Payment'),
          rowFooterData('Total Before Discount', billModel.calculateBillRow().toString()),
          rowFooterData('Discount', billModel.getDiscount().toString()),
          rowFooterData('Total After Discount', billModel.calculateBillRowWithDiscount().toString()),
          rowFooterData('Paid', widget.bill.paid.toString()),
          rowFooterData('Change', calculateChange().toString()),
          navigateButton
        ],
      ),
    );
  }
}
