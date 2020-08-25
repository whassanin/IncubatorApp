import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/creditcardmodel.dart';
import 'package:incubatorapp/widgets/form/creditcardformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewCreditCardScreen extends StatelessWidget {
  static const routeName = '/newcreditcardscreen';

  NewCreditCardScreen();

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
              title: Text('New Credit Card',
                  style: TextStyle(color: Colors.white)),
            ),
            body: CreditCardFormWidget(isEdit: false,),
          );
        },
      ),
    );
  }
}
