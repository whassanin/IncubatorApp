import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum ExtraColumn { name, price }

class ExtraFormWidget extends StatefulWidget {
  final bool isEdit;
  ExtraFormWidget({this.isEdit});

  @override
  _ExtraFormWidgetState createState() => _ExtraFormWidgetState();
}

class _ExtraFormWidgetState extends State<ExtraFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController priceTEC = new TextEditingController();

  void setData(ExtraColumn extraColumn, String val) {
    if (extraColumn == ExtraColumn.name) {
      extraModel.setName(val);
    } else if (extraColumn == ExtraColumn.price) {
      extraModel.setPrice(double.parse(val));
    }
  }

  void getData() {
    nameTEC.text = extraModel.getName();
    if (extraModel.getPrice() > 0) {
      priceTEC.text = extraModel.getPrice().toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await extraModel.update();
        } else {
          isCheck = await extraModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await extraModel.delete();
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
      ExtraColumn extraColumns, TextEditingController columnTEC,
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
          setData(extraColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(extraColumns, v);
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
    columnTextField('Name', false, false, ExtraColumn.name, nameTEC);

    Widget priceField =
    columnTextField('Price', true, false, ExtraColumn.price, priceTEC);

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
