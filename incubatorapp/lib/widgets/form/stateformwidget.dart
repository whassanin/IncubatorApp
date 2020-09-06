import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubatorapp/main.dart';

enum StateColumn { name }

class StateFormWidget extends StatefulWidget {
  final bool isEdit;
  StateFormWidget({this.isEdit});

  @override
  _StateFormWidgetState createState() => _StateFormWidgetState();
}

class _StateFormWidgetState extends State<StateFormWidget> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController nameTEC = new TextEditingController();

  void setData(StateColumn stateColumn, String val) {
    if (stateColumn == StateColumn.name) {
      stateTypeModel.setName(val);
    }
  }

  void getData() {
    nameTEC.text = stateTypeModel.getName();
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      bool isCheck = false;

      if (widget.isEdit != null) {
        if (widget.isEdit) {
          isCheck = await stateTypeModel.update();
        } else {
          isCheck = await stateTypeModel.create();
        }
      }

      if (isCheck) {
        Navigator.pop(context);
      }
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await stateTypeModel.delete();
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
      StateColumn stateColumns, TextEditingController columnTEC,
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
          setData(stateColumns, v);
        },
        onFieldSubmitted: (v) {
          setData(stateColumns, v);
        },
        onTap: () {
          if (fun != null) {
            fun();
          }
        },
      ),
    );
  }

  Widget editButtons(String title, Color color,{VoidCallback fun}) {
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
              if(fun!=null){
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
    Widget nameField = columnTextField('Name', false, false, StateColumn.name, nameTEC);

    Widget saveButton = editButtons('Save', Colors.cyan,fun: save);

    Widget deleteButton = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        deleteButton = editButtons('Delete', Colors.red,fun: delete);
      }
    }

    Widget rowButtons = Row(
      children: <Widget>[
        /*deleteButton,*/
        saveButton
      ],
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            nameField,
            rowButtons,
          ],
        ),
      ),
    );
  }
}
