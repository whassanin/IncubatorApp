import 'package:flutter/material.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/widgets/row/billrowwidget.dart';

class BillListWidget extends StatefulWidget {
  final List<Bill> billList;
  BillListWidget({this.billList});
  @override
  _BillListWidgetState createState() => _BillListWidgetState();
}

class _BillListWidgetState extends State<BillListWidget> {
  List<Bill> addCalculatedList = [];

  double calculateTotal() {
    double total = 0;

    if (widget.billList != null) {
      if (widget.billList.length > 0) {
        widget.billList.forEach((b) {
          int i = addCalculatedList.indexOf(b);

          if (i < 0) {
            double sum = b.dayCost +
                b.incubatorClean +
                b.consumable +
                b.analysis +
                b.xRay +
                b.lightRays +
                b.medicine;

            if(b.billExtraList!=null){
              if(b.billExtraList.length > 0){
                b.billExtraList.forEach((be) {
                  sum+=be.cost;
                });
              }
            }

            total += sum;
          }
        });
      }
    }

    return total;
  }

  double calculatePaid() {
    double total = 0;

    if (widget.billList != null) {
      if (widget.billList.length > 0) {
        widget.billList.forEach((b) {
          int i = addCalculatedList.indexOf(b);

          if (i < 0) {
            total += b.paid;
          }
        });
      }
    }

    return total;
  }

  double calculateChange(){
    double total = calculateTotal();
    double paid = calculatePaid();
    return paid - total;
  }

  @override
  void initState() {
    // TODO: implement initState
    addCalculatedList.clear();
    super.initState();
  }

  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.billList != null) {
      if (widget.billList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.billList.length,
          itemBuilder: (BuildContext context, int i) {
            return BillRowWidget(
              bill: widget.billList[i],
            );
          },
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: currentWidget,
    );
  }

  Widget containerTotalWidget(String title,String val){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                val,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: getList()));

    Widget positionTotal = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              containerTotalWidget('Total:',calculateTotal().toString()),
              containerTotalWidget('Paid:',calculatePaid().toString()),
              containerTotalWidget('Change:',calculateChange().toString()),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        positionList,
        positionTotal,
      ],
    );
  }
}
