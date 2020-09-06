import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum BillColumn { discount, paid, total, change }

class BillFormWidget extends StatefulWidget {
  final bool isEdit;
  BillFormWidget({this.isEdit});

  @override
  _BillFormWidgetState createState() => _BillFormWidgetState();
}

class _BillFormWidgetState extends State<BillFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController discountTEC = new TextEditingController();
  TextEditingController beforeTotalTEC = new TextEditingController();
  TextEditingController afterTotalTEC = new TextEditingController();
  TextEditingController paidTEC = new TextEditingController();
  TextEditingController changeTEC = new TextEditingController();

  void setData(BillColumn billColumn, String val) {
    if (billColumn == BillColumn.discount) {
      billModel.setDiscount(double.parse(val));
    } else if (billColumn == BillColumn.paid) {
      billModel.setPaid(double.parse(val));
    }
  }

  void getData() {
    double d = billModel.getDiscount();
    if (d > 0) {
      discountTEC.text = d.toString();
    }

    double t = billModel.calculateBillRow();

    if (t > 0) {
      beforeTotalTEC.text = t.toString();
      afterTotalTEC.text = t.toString();
    }

    double p = billModel.getPaid();

    if (p > 0) {
      paidTEC.text = p.toString();
    }

    double c = p - t;
    if (c > 0) {
      changeTEC.text = c.toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await billModel.update();
        } else {
          isCheck = await billModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await billModel.delete();
    if (isCheck) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget columnTextField(String name, bool isNumber, bool isObscure,
      BillColumn billColumns, TextEditingController columnTEC,
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
          setData(billColumns, v);
          if (billColumns == BillColumn.discount) {
            double t = double.parse(beforeTotalTEC.text) -
                double.parse(discountTEC.text);
            afterTotalTEC.text = t.toString();
          }else if(billColumns == BillColumn.paid){
            double c = double.parse(paidTEC.text) -
                double.parse(afterTotalTEC.text);
            changeTEC.text = c.toString();
          }
        },
        onFieldSubmitted: (v) {
          setData(billColumns, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  Widget editButtons(String title, Color color, {VoidCallback fun}) {
    Widget button = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
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

    return button;
  }

  @override
  Widget build(BuildContext context) {
    Widget discountField = columnTextField(
        'Discount', true, false, BillColumn.discount, discountTEC);

    Widget beforeTotalField =
        columnTextField('Total before discount', true, false, BillColumn.total, beforeTotalTEC);

    Widget afterTotalField =
        columnTextField('Total after discount', true, false, BillColumn.total, afterTotalTEC);

    Widget paidField =
        columnTextField('Paid', true, false, BillColumn.paid, paidTEC);

    Widget changeField =
        columnTextField('Change', true, false, BillColumn.change, changeTEC);

    Widget saveButton = editButtons('Save', Colors.cyan, fun: save);

    Widget deleteButton = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        deleteButton = editButtons('Delete', Colors.red, fun: delete);
      }
    }

    Widget rowButtons = Row(
      children: <Widget>[/*deleteButton,*/ saveButton],
    );

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              beforeTotalField,
              discountField,
              afterTotalField,
              paidField,
              changeField,
              rowButtons,
            ],
          ),
        ),
      ),
    );
  }
}
