import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/creditcardmodel.dart';
import 'package:incubatorapp/screens/creditcardscreen/newcreditcardscreen.dart';
import 'package:incubatorapp/widgets/List/creditcardlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCardScreen extends StatelessWidget {
  static const routeName = '/creditcardscreen';

  CreditCardScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: creditCardModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            CreditCardModel creditCardModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Credit Card',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    creditCardModel.createCreditCard();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>NewCreditCardScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: CreditCardListWidget(
              creditCardList: creditCardModel.creditCardList,
            )
          );
        },
      ),
    );
  }
}
