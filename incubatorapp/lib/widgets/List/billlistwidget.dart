import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/screens/creditcardscreen/creditcardscreen.dart';
import 'package:incubatorapp/widgets/row/billrowwidget.dart';

class BillListWidget extends StatefulWidget {
  final List<Bill> billList;
  BillListWidget({this.billList});
  @override
  _BillListWidgetState createState() => _BillListWidgetState();
}

class _BillListWidgetState extends State<BillListWidget> {
  void pay() {
    double t = billModel.calculateTotalChange();
    if (t > 0) {
      creditCardModel.setIsPayment(true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreditCardScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
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
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Bills(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Bills(s) Available'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 125),
      child: currentWidget,
    );
  }

  Widget containerTotalWidget(String title, String val) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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

  Widget calculateButton(String title, {VoidCallback fun}) {
    Widget buttonContainer = Container(
      decoration: BoxDecoration(color: Colors.cyan),
      height: 58,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );

    Widget buttonGesture = GestureDetector(
      onTap: () {
        if (fun != null) {
          fun();
        }
      },
      child: buttonContainer,
    );

    Widget buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: buttonGesture,
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: buttonRow,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: getList()));

    Widget totalContainer = Container(
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
          containerTotalWidget(
              'Total:', billModel.calculateTotalCost().toString()),
          containerTotalWidget(
              'Paid:', billModel.calculateTotalPaid().toString()),
          containerTotalWidget(
              'Change:', billModel.calculateTotalChange().toString()),
        ],
      ),
    );

    Widget currentButtonContainer = calculateButton('Pay', fun: pay);

    if (userPermission.isAccountant) {
      currentButtonContainer = calculateButton('Calculate',
          fun: billModel.calculateBillsForAccountant);
    }

    Widget positionTotal = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              totalContainer,
              currentButtonContainer,
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
