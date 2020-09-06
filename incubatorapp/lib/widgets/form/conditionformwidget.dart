import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum ConditionColumn { name, price }

class ConditionFormWidget extends StatefulWidget {
  final bool isEdit;
  ConditionFormWidget({this.isEdit});

  @override
  _ConditionFormWidgetState createState() => _ConditionFormWidgetState();
}

class _ConditionFormWidgetState extends State<ConditionFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController priceTEC = new TextEditingController();

  void setData(ConditionColumn conditionColumn, String val) {
    if (conditionColumn == ConditionColumn.name) {
      conditionModel.setName(val);
    } else if (conditionColumn == ConditionColumn.price) {
      conditionModel.setPrice(double.parse(val));
    }
  }

  void getData() {
    nameTEC.text = conditionModel.getName();
    if (conditionModel.getPrice() > 0) {
      priceTEC.text = conditionModel.getPrice().toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await conditionModel.update();
        } else {
          isCheck = await conditionModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await conditionModel.delete();
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
      ConditionColumn conditionColumns, TextEditingController columnTEC,
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
          setData(conditionColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(conditionColumns, v);
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
        columnTextField('Name', false, false, ConditionColumn.name, nameTEC);

    Widget priceField =
        columnTextField('Price', true, false, ConditionColumn.price, priceTEC);

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
            rowButtons,
          ],
        ),
      ),
    );
  }
}
