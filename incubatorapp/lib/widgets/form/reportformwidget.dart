import 'package:flutter/material.dart';

class ReportFormWidget extends StatefulWidget {
  @override
  _ReportFormWidgetState createState() => _ReportFormWidgetState();
}

enum ReportColumns { subject, body }

class _ReportFormWidgetState extends State<ReportFormWidget> {
  TextEditingController subjectTEC = new TextEditingController();
  TextEditingController bodyTEC = new TextEditingController();

  void sendMail() async{

  }

  Widget columnTextField(
    String name,
    bool isExpanded,
    TextEditingController columnTEC,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: null,
        maxLines: null,
        textAlign: TextAlign.start,
        expands: isExpanded,
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
        validator: (v) {
          if (v.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget sendButton = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
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
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  sendMail();
                },
              ),
            ),
          ),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          columnTextField('Subject', false, subjectTEC),
          Expanded(child: columnTextField('Body', true, bodyTEC)),
          sendButton
        ],
      ),
    );
  }
}
