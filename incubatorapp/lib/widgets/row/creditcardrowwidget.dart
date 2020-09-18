import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:incubatorapp/screens/creditcardscreen/editcreditcardscreen.dart';
import 'package:incubatorapp/screens/paymentscreen/paymentscreen.dart';

class CreditCardRowWidget extends StatefulWidget {
  final CreditCard creditCard;
  CreditCardRowWidget({this.creditCard});
  @override
  _CreditCardRowWidgetState createState() => _CreditCardRowWidgetState();
}

class _CreditCardRowWidgetState extends State<CreditCardRowWidget> {
  Widget display(String name, String val) {
    Widget data = Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        val,
      ),
    );

    Widget title = Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    Widget columnData = Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          data,
        ],
      ),
    );

    return columnData;
  }

  @override
  Widget build(BuildContext context) {
    String expirationDate = widget.creditCard.expireMonth.toString() +
        ' / ' +
        widget.creditCard.expireYear.toString();

    String number = '';

    for (int i = 0; i < widget.creditCard.number.length - 4; i++) {
      int v = int.tryParse(widget.creditCard.number[i]);
      if (v == null) {
        number += '  ';
      } else {
        number += 'x';
      }
    }

    for (int i = widget.creditCard.number.length - 4;
        i < widget.creditCard.number.length;
        i++) {
      number += widget.creditCard.number[i];
    }

    Widget columnInfoList = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        display('Holder', widget.creditCard.holder),
        display('Number', number),
        display('Expire Date:', expirationDate),
      ],
    );

    Widget cardColumn = Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: columnInfoList,
    );

    Widget gestureCard = GestureDetector(
      child: cardColumn,
      onTap: () {
        creditCardModel.editCreditCard(widget.creditCard);

        if (creditCardModel.isPayment) {
          if (creditCardModel.validateDate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCreditCardScreen(),
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCreditCardScreen(),
            ),
          );
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: gestureCard,
    );
  }
}
