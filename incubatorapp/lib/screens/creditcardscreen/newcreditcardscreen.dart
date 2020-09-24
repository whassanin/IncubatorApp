import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/creditcardmodel.dart';
import 'package:incubatorapp/widgets/form/creditcardformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewCreditCardScreen extends StatefulWidget {
  static const routeName = '/newcreditcardscreen';

  NewCreditCardScreen();

  @override
  _NewCreditCardScreenState createState() => _NewCreditCardScreenState();
}

class _NewCreditCardScreenState extends State<NewCreditCardScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'New Credit Card';

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
              title: Text(title, style: TextStyle(color: Colors.white)),
            ),
            body: CreditCardFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
