import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum MedicineColumn { name, price,amount }

class MedicineFormWidget extends StatefulWidget {
  final bool isEdit;
  MedicineFormWidget({this.isEdit});

  @override
  _MedicineFormWidgetState createState() => _MedicineFormWidgetState();
}

class _MedicineFormWidgetState extends State<MedicineFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController nameTEC = new TextEditingController();
  TextEditingController priceTEC = new TextEditingController();
  TextEditingController amountTEC = new TextEditingController();

  void setData(MedicineColumn medicineColumn, String val) {
    if (medicineColumn == MedicineColumn.name) {
      medicineModel.setName(val);
    } else if (medicineColumn == MedicineColumn.price) {
      medicineModel.setPrice(double.parse(val));
    } else if (medicineColumn == MedicineColumn.amount) {
      medicineModel.setAmount(double.parse(val));
    }
  }

  void getData() {
    nameTEC.text = medicineModel.getName();
    if (medicineModel.getPrice() > 0) {
      priceTEC.text = medicineModel.getPrice().toString();
    }
    if (medicineModel.getAmount() > 0) {
      amountTEC.text = medicineModel.getAmount().toString();
    }
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await medicineModel.update();
        } else {
          isCheck = await medicineModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await medicineModel.delete();
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
      MedicineColumn medicineColumns, TextEditingController columnTEC,
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
          setData(medicineColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(medicineColumns, v);
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
    columnTextField('Name', false, false, MedicineColumn.name, nameTEC);

    Widget priceField =
    columnTextField('Price', true, false, MedicineColumn.price, priceTEC);

    Widget amountField =
    columnTextField('Amount', true, false, MedicineColumn.amount, amountTEC);

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
