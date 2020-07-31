import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';

class IncubatorFormWidget extends StatefulWidget {
  final IncubatorModel incubatorModel;

  IncubatorFormWidget({this.incubatorModel});

  @override
  _IncubatorFormWidgetState createState() => _IncubatorFormWidgetState();
}

class _IncubatorFormWidgetState extends State<IncubatorFormWidget> {
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.incubatorModel.createIncubator();
  }

  void save() async {
    bool isCheck = await widget.incubatorModel.create();
    await Future.delayed(Duration(seconds: 1));
    if (isCheck) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget nameField = TextFormField(
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
          widget.incubatorModel.setName(v);
        }
        return null;
      },
      onChanged: (v) {
        widget.incubatorModel.setName(v);
      },
      onFieldSubmitted: (v) {
        widget.incubatorModel.setName(v);
      },
    );

    Widget saveButton = Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text('Save'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                save();
              }
            },
          ),
        )
      ],
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            nameField,
            saveButton,
          ],
        ),
      ),
    );
  }
}
