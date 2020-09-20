import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:incubatorapp/widgets/row/creditcardrowwidget.dart';

class CreditCardListWidget extends StatefulWidget {
  final List<CreditCard> creditCardList;
  CreditCardListWidget({this.creditCardList});
  @override
  _CreditCardListWidgetState createState() => _CreditCardListWidgetState();
}

class _CreditCardListWidgetState extends State<CreditCardListWidget> {
  Widget getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.creditCardList != null) {
      if (widget.creditCardList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.creditCardList.length,
          itemBuilder: (BuildContext context, int i) {
            return CreditCardRowWidget(
              creditCard: widget.creditCardList[i],
            );
          },
        );
      } else {
        if (creditCardModel.isAdding == false) {
          currentWidget = Center(
            child: Container(
              child: Text('No Credit Card(s) Available'),
            ),
          );
        }
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Credit Card(s) Available'),
        ),
      );
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }
}
