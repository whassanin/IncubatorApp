import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum ConsumableColumn { name, price,amount }

class ConsumableFormWidget extends StatefulWidget {
  final bool isEdit;
  ConsumableFormWidget({this.isEdit});

  @override
  _ConsumableFormWidgetState createState() => _ConsumableFormWidgetState();
}

class _ConsumableFormWidgetState extends State<ConsumableFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController priceTEC = new TextEditingController();
  TextEditingController amountTEC = new TextEditingController();

  void setData(ConsumableColumn consumableColumn, String val) {
    if (consumableColumn == ConsumableColumn.name) {
      consumableModel.setName(val);
    } else if (consumableColumn == ConsumableColumn.price) {
      consumableModel.setPrice(double.parse(val));
    } else if (consumableColumn == ConsumableColumn.amount) {
      consumableModel.setAmount(double.parse(val));
    }
  }

  void getData() {
    nameTEC.text = consumableModel.getName();
    if (consumableModel.getPrice() > 0) {
      priceTEC.text = consumableModel.getPrice().toString();
    }
    if (consumableModel.getAmount() > 0) {
      amountTEC.text = consumableModel.getAmount().toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await consumableModel.update();
        } else {
          isCheck = await consumableModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await consumableModel.delete();
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
      ConsumableColumn consumableColumns, TextEditingController columnTEC,
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
          setData(consumableColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(consumableColumns, v);
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
    Widget nameField =
    columnTextField('Name', false, false, ConsumableColumn.name, nameTEC);

    Widget priceField =
    columnTextField('Price', true, false, ConsumableColumn.price, priceTEC);

    Widget amountField =
    columnTextField('Amount', true, false, ConsumableColumn.amount, amountTEC);

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

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            nameField,
            priceField,
            amountField,
            rowButtons,
          ],
        ),
      ),
    );
  }
}
