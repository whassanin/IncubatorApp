import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:incubatorapp/screens/creditcardscreen/editcreditcardscreen.dart';

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

    Widget columnInfoList = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        display('Holder', widget.creditCard.holder),
        display('Number', widget.creditCard.number),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditCreditCardScreen(),
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: gestureCard,
    );
  }
}
