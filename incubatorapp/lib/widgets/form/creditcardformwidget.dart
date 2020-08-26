import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';
import 'package:incubatorapp/screens/paymentscreen/successfullmessagescreen.dart';

enum CreditCardColumn { number, holder, expireYear, expireMonth, cvv }

class CreditCardFormWidget extends StatefulWidget {
  final bool isEdit;
  CreditCardFormWidget({this.isEdit});
  @override
  _CreditCardFormWidgetState createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController numberTEC = new TextEditingController();
  TextEditingController holderTEC = new TextEditingController();
  TextEditingController expireMonthTEC = new TextEditingController();
  TextEditingController expireYearTEC = new TextEditingController();
  TextEditingController cvvTEC = new TextEditingController();

  void setData(CreditCardColumn creditCardColumn, String val) {
    if (creditCardColumn == CreditCardColumn.number) {
      creditCardModel.setNumber(val);
    } else if (creditCardColumn == CreditCardColumn.holder) {
      creditCardModel.setHolder(val);
    } else if (creditCardColumn == CreditCardColumn.expireMonth) {
      creditCardModel.setExpireMonth(int.parse(val));
    } else if (creditCardColumn == CreditCardColumn.expireYear) {
      creditCardModel.setExpireYear(int.parse(val));
    }
  }

  void getData() {
    numberTEC.text = creditCardModel.getNumber();
    holderTEC.text = creditCardModel.getNumber();
    expireMonthTEC.text = creditCardModel.getExpireMonth().toString();
    expireYearTEC.text = creditCardModel.getExpireYear().toString();
  }

  void save() {
    if (_formKey.currentState.validate()) {
      creditCardModel.setPatientId(patientModel.currentPatient.userId);
      if (widget.isEdit) {
        creditCardModel.update();
      } else {
        creditCardModel.create();
        creditCardModel.readByPatientId(patientModel.currentPatient.userId);
      }
      Navigator.pop(context);
    }
  }

  void payment() {
    if (_formKey.currentState.validate()) {
      creditCardModel.setIsPayment(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessfulMessageScreen(),
        ),
      );
    }
  }

  bool validateDate() {
    bool isCheck = false;

    int cm = DateTime.now().month;
    int cy = DateTime.now().year;
    int m = creditCardModel.getExpireMonth();
    int y = creditCardModel.getExpireYear();

    if (y > cy) {
      isCheck = true;
    } else {
      if (y == cy) {
        if (m >= cm) {
          isCheck = true;
        }
      }
    }

    return isCheck;
  }

  Widget editButtons() {
    Widget paymentButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              'Pay',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              payment();
            },
          ),
        ),
      ),
    );

    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              save();
            },
          ),
        ),
      ),
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              creditCardModel.delete();
            },
          ),
        ),
      ),
    );

    Widget rowCreateButtons = Row(
      children: <Widget>[saveButton],
    );

    Widget rowEditButtons = Row(
      children: <Widget>[deleteButton, saveButton],
    );

    Widget rowPaymentButtons = Row(
      children: <Widget>[paymentButton],
    );

    Widget rowButtons = Container();

    if (creditCardModel.isPayment) {
      rowButtons = rowPaymentButtons;
    } else {
      if (widget.isEdit != null) {
        if (widget.isEdit) {
          rowButtons = rowEditButtons;
        } else {
          rowButtons = rowCreateButtons;
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: rowButtons,
    );
  }

  Widget columnTextField(String name, bool isNumber, bool isObscure,
      CreditCardColumn creditCardColumn, TextEditingController columnTEC,
      {VoidCallback fun}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        obscureText: isObscure,
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
        readOnly: (fun != null ? true : false),
        keyboardType: (isNumber ? TextInputType.number : null),
        inputFormatters: (isNumber
            ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            : null),
        validator: (v) {
          if (v.isEmpty) {
            return 'Required';
          } else {
            if (creditCardColumn == CreditCardColumn.expireMonth) {
              if (validateDate() == false) {
                return 'invalid month';
              }
            } else if (creditCardColumn == CreditCardColumn.expireYear) {
              if (validateDate() == false) {
                return 'invalid Year';
              }
            }
          }
          return null;
        },
        onChanged: (v) {
          setData(creditCardColumn, v);
        },
        onFieldSubmitted: (v) {
          setData(creditCardColumn, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cvvTextField = Container();

    if (creditCardModel.isPayment != null) {
      if (creditCardModel.isPayment) {
        cvvTextField = columnTextField(
          'CVV',
          true,
          false,
          CreditCardColumn.cvv,
          cvvTEC,
        );
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              columnTextField(
                'Number',
                true,
                false,
                CreditCardColumn.number,
                numberTEC,
              ),
              columnTextField(
                'Holder',
                false,
                false,
                CreditCardColumn.holder,
                holderTEC,
              ),
              columnTextField(
                'Expire Month',
                true,
                false,
                CreditCardColumn.expireMonth,
                expireMonthTEC,
              ),
              columnTextField(
                'Expire Year',
                true,
                false,
                CreditCardColumn.expireYear,
                expireYearTEC,
              ),
              cvvTextField,
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
