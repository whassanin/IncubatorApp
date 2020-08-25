import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';
enum CreditCardColumn{number,holder,expireYear,expireMonth}

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

  void setData(CreditCardColumn creditCardColumn,String val){
    if(creditCardColumn == CreditCardColumn.number){
      creditCardModel.setNumber(val);
    }else if(creditCardColumn == CreditCardColumn.holder){
      creditCardModel.setHolder(val);
    }else if(creditCardColumn == CreditCardColumn.expireMonth){
      creditCardModel.setExpireMonth(int.parse(val));
    }else if(creditCardColumn == CreditCardColumn.expireYear){
      creditCardModel.setExpireYear(int.parse(val));
    }
  }

  void getData(){
    numberTEC.text = creditCardModel.getNumber();
    holderTEC.text = creditCardModel.getNumber();
    expireMonthTEC.text = creditCardModel.getExpireMonth().toString();
    expireYearTEC.text = creditCardModel.getExpireYear().toString();
  }

  void save(){
    creditCardModel.setPatientId(patientModel.currentPatient.userId);
    creditCardModel.create();
    creditCardModel.readByPatientId(patientModel.currentPatient.userId);
    Navigator.pop(context);
  }

  Widget editButtons() {
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
            child: Text('Delete',style: TextStyle(color: Colors.white),),
            onPressed: () {},
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
            ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
            : null),
        validator: (v) {
          if (v.isEmpty) {
            return 'Required';
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
    if(widget.isEdit){
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
              editButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
