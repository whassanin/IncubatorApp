import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/screens/billscreen/billdetailscreen.dart';

class BillRowWidget extends StatefulWidget {
  final Bill bill;

  BillRowWidget({this.bill});

  @override
  _BillRowWidgetState createState() => _BillRowWidgetState();
}

class _BillRowWidgetState extends State<BillRowWidget> {
  Widget billRow() {
    String v = widget.bill.createdDate.day.toString();
    v = v + '/' + widget.bill.createdDate.month.toString();
    v = v + '/' + widget.bill.createdDate.year.toString();

    double total = billModel.calculateBillRow(widget.bill);

    double change = widget.bill.paid - total;

    Widget rowDate = Text('Date: ' + v);

    Widget rowTotal = Text('Total: ' + total.toString());

    Widget rowPaid = Text('Paid: ' + widget.bill.paid.toString());

    Widget rowChange = Text('Change: ' + change.toString());

    Widget rowData = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        rowTotal,
        rowPaid,
        rowChange,
      ],
    );

    Widget colData = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        rowDate,
        SizedBox(
          height: 10,
        ),
        rowData
      ],
    );

    Widget rowCard = Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: colData,
        ),
      ),
    );

    return GestureDetector(
      child: rowCard,
      onTap: () {
        billModel.editBill(widget.bill);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BillDetailScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return billRow();
  }
}
