import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/views/payment/paymentscreen/errormessagescreen.dart';
import 'package:incubatorapp/views/payment/paymentscreen/successfullmessagescreen.dart';

class PaymentFormWidget extends StatefulWidget {
  PaymentFormWidget();
  @override
  _PaymentFormWidgetState createState() => _PaymentFormWidgetState();
}

class _PaymentFormWidgetState extends State<PaymentFormWidget> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController totalTEC = new TextEditingController();
  TextEditingController cardNumberTEC = new TextEditingController();
  TextEditingController cardCVVTEC = new TextEditingController();

  void payment() async {
    if (_formKey.currentState.validate()) {
      if (billModel.billList.length > 0) {
        int index = billModel.billList.length - 1;
        billModel.editBill(billModel.billList[index]);
        double t = double.parse(totalTEC.text) + billModel.getPaid();
        billModel.setPaid(t);

        bool isCheck = await billModel.update();
        if (isCheck) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessfulMessageScreen(),
            ),
          );
        }else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ErrorMessageScreen(),
            ),
          );
        }
      }
    }
  }

  Widget columnTextField(String name, bool isReadOnly, bool isNumber,
      TextEditingController columnTEC) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: columnTEC,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          labelText: name,
        ),
        readOnly: isReadOnly,
        keyboardType: (isNumber ? TextInputType.number : null),
        inputFormatters: (isNumber
            ? <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ]
            : null),
        validator: (v) {
          if (v.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }

  Widget button(String title, Color color, VoidCallback fun) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (fun != null) {
                fun();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardNumberTEC.text = creditCardModel.getNumber(true);
    double v = billModel.calculateTotalChange();
    if (v < 0) {
      v *= -1;
    }
    totalTEC.text = v.toString();
  }

  @override
  Widget build(BuildContext context) {
    Widget paymentButton = Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [button('Pay', Colors.cyan, payment)],
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          columnTextField('Total', true, true, totalTEC),
          columnTextField('Card Number', true, true, cardNumberTEC),
          columnTextField('CVV', false, true, cardCVVTEC),
          paymentButton
        ],
      ),
    );
  }
}
