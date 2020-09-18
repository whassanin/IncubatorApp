import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/creditcardmodel.dart';
import 'package:incubatorapp/screens/creditcardscreen/newcreditcardscreen.dart';
import 'package:incubatorapp/widgets/List/creditcardlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCardScreen extends StatefulWidget {
  static const routeName = '/creditcardscreen';

  CreditCardScreen();

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(creditCardModel.isPayment == true){
      creditCardModel.setIsPayment(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CreditCardModel>(
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
