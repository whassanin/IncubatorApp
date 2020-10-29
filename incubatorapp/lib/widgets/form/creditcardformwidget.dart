import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum CreditCardColumn { number, holder, expireYear, expireMonth, cvv }

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CreditCardFormWidget extends StatefulWidget {
  final bool isEdit;
  CreditCardFormWidget({this.isEdit});
  @override
  _CreditCardFormWidgetState createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget> {
  final _formKey = new GlobalKey<FormState>();
  List<int> yearDataList = [];

  TextEditingController numberTEC = new TextEditingController();
  TextEditingController holderTEC = new TextEditingController();
  TextEditingController expireMonthTEC = new TextEditingController();
  TextEditingController expireYearTEC = new TextEditingController();
  TextEditingController cvvTEC = new TextEditingController();

  void getYear(){
    DateTime dt = DateTime.now();
    int currentYear = dt.year;
    for(int i = currentYear;i<=currentYear+50;i++){
      yearDataList.add(i);
    }
  }

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
    numberTEC.text = creditCardModel.getNumber(true);
    holderTEC.text = creditCardModel.getHolder();
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

  void delete() {
    creditCardModel.delete();
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

  Widget editButtons() {
    Widget saveButton = button('Save', Colors.cyan, save);

    Widget deleteButton = button('Delete', Colors.red, delete);

    Widget rowCreateButtons = Row(
      children: <Widget>[saveButton],
    );

    Widget rowEditButtons = Row(
      children: <Widget>[deleteButton, saveButton],
    );

    Widget rowButtons = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        rowButtons = rowEditButtons;
      } else {
        rowButtons = rowCreateButtons;
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
            ? <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                (creditCardColumn == CreditCardColumn.number
                    ? new CardNumberInputFormatter()
                    : null)
              ]
            : null),
        validator: (v) {
          if (v.isEmpty) {
            return 'Required';
          } else {
            if (creditCardColumn == CreditCardColumn.expireMonth) {
              if (creditCardModel.validateDate() == false) {
                return 'invalid month';
              }
            } else if (creditCardColumn == CreditCardColumn.expireYear) {
              if (creditCardModel.validateDate() == false) {
                return 'invalid Year';
              }
            } else if (creditCardColumn == CreditCardColumn.number) {
              if (creditCardModel.getNumber(false).length > 22) {
                return 'invalid Number greater thant 16';
              } else if (creditCardModel.getNumber(false).length < 22) {
                return 'invalid Number less than 16';
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

  void showMonthPicker() {
    Widget monthList = ListView.separated(
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            (index + 1).toString(),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            expireMonthTEC.text = (index + 1).toString();
            setData(CreditCardColumn.expireMonth, (index + 1).toString());
            Navigator.pop(context);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 150,
              height: MediaQuery.of(context).size.height * 0.75,
              child: monthList,
            ),
          ],
        );
      },
    );
  }

  void showYearPicker() {

    Widget yearList = ListView.separated(
      shrinkWrap: true,
      itemCount: yearDataList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            yearDataList[index].toString(),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            expireYearTEC.text = yearDataList[index].toString();
            setData(CreditCardColumn.expireYear, yearDataList[index].toString());
            Navigator.pop(context);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              width: 150,
              height: MediaQuery.of(context).size.height * 0.75,
              child: yearList,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getYear();

    if (widget.isEdit) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {

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
              columnTextField('Expire Month', true, false,
                  CreditCardColumn.expireMonth, expireMonthTEC,
                  fun: showMonthPicker),
              columnTextField('Expire Year', true, false,
                  CreditCardColumn.expireYear, expireYearTEC,
                  fun: showYearPicker),
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
