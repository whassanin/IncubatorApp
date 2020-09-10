import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum LaboratoryColumn { name, price }

class LaboratoryFormWidget extends StatefulWidget {
  final bool isEdit;
  LaboratoryFormWidget({this.isEdit});

  @override
  _LaboratoryFormWidgetState createState() => _LaboratoryFormWidgetState();
}

class _LaboratoryFormWidgetState extends State<LaboratoryFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController priceTEC = new TextEditingController();

  void setData(LaboratoryColumn laboratoryColumn, String val) {
    if (laboratoryColumn == LaboratoryColumn.name) {
      laboratoryModel.setName(val);
    } else if (laboratoryColumn == LaboratoryColumn.price) {
      laboratoryModel.setPrice(double.parse(val));
    }
  }

  void getData() {
    nameTEC.text = laboratoryModel.getName();
    if (laboratoryModel.getPrice() > 0) {
      priceTEC.text = laboratoryModel.getPrice().toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await laboratoryModel.update();
        } else {
          isCheck = await laboratoryModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await laboratoryModel.delete();
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
      LaboratoryColumn laboratoryColumns, TextEditingController columnTEC,
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
          setData(laboratoryColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(laboratoryColumns, v);
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
        columnTextField('Name', false, false, LaboratoryColumn.name, nameTEC);

    Widget priceField =
        columnTextField('Price', true, false, LaboratoryColumn.price, priceTEC);

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
