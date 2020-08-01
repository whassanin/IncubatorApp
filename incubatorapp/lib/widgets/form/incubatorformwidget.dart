import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';

class IncubatorFormWidget extends StatefulWidget {
  final bool isEdit;
  IncubatorFormWidget({this.isEdit});

  @override
  _IncubatorFormWidgetState createState() => _IncubatorFormWidgetState();
}

class _IncubatorFormWidgetState extends State<IncubatorFormWidget> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController nameTED = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTED.text = incubatorModel.getName();
  }

  void save() async {
    bool isCheck = false;

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        isCheck = await incubatorModel.update();
      } else {
        isCheck = await incubatorModel.create();
      }
    } else {
      isCheck = await incubatorModel.create();
    }

    await Future.delayed(Duration(seconds: 1));
    if (isCheck) {
      Navigator.pop(context);
    }
  }

  void delete() async {
    bool isCheck = false;
    isCheck = await incubatorModel.delete();
    await Future.delayed(Duration(seconds: 1));
    if (isCheck) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget nameField = TextFormField(
      controller: nameTED,
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorStyle: TextStyle(fontSize: 14.0),
      ),
      validator: (v) {
        if (v.isEmpty || v == null) {
          return 'Required';
        } else {
          incubatorModel.setName(v);
        }
        return null;
      },
      onChanged: (v) {
        incubatorModel.setName(v);
      },
      onFieldSubmitted: (v) {
        incubatorModel.setName(v);
      },
    );

    Widget saveButton = Expanded(
      child: RaisedButton(
        child: Text('Save'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            save();
          }
        },
      ),
    );

    Widget deleteButton = Container();

    if (widget.isEdit != null) {
      if (widget.isEdit) {
        deleteButton = Expanded(
          child: RaisedButton(
            child: Text('Delete'),
            onPressed: () {
              delete();
            },
          ),
        );
      }
    }

    Widget rowButtons = Row(
      children: <Widget>[
        deleteButton,
        (widget.isEdit != null
            ? SizedBox(
                width: 10,
              )
            : Container()),
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
