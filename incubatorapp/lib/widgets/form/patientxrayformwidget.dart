import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';

class PatientXRayFormWidget extends StatefulWidget {
  final PatientXRay patientXRay;
  final XRay xRay;
  PatientXRayFormWidget({this.patientXRay, this.xRay});
  @override
  _PatientXRayFormWidgetState createState() => _PatientXRayFormWidgetState();
}

class _PatientXRayFormWidgetState extends State<PatientXRayFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController dateTEC = new TextEditingController();
  TextEditingController commentTEC = new TextEditingController();

  String dateFormat() {
    String v = widget.patientXRay.createdDate.day.toString();
    v = v + '/' + widget.patientXRay.createdDate.month.toString();
    v = v + '/' + widget.patientXRay.createdDate.year.toString();
    return v;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.xRay.name;
    dateTEC.text = dateFormat();
    commentTEC.text = widget.patientXRay.comment;
  }

  @override
  Widget build(BuildContext context) {
    Widget nameTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: nameTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'XRay Name',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget dateTextField = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              readOnly: true,
              controller: dateTEC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                labelText: 'Date',
              ),
              validator: (v) {
                return null;
              },
              onChanged: (v) {},
              onFieldSubmitted: (v) {},
            ),
          ),
        )
      ],
    );

    Widget commentTextField = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          minLines: null,
          maxLines: null,
          expands: true,
          readOnly: (userPermission.isDoctor ? false : true),
          controller: commentTEC,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            labelText: 'Comment',
          ),
          validator: (v) {
            return null;
          },
          onChanged: (v) {
            patientXRayModel.setComment(v);
          },
          onFieldSubmitted: (v) {
            patientXRayModel.setComment(v);
          },
        ),
      ),
    );

    Widget deleteButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
            onPressed: () {
              patientXRayModel.delete();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget saveButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              patientXRayModel.update();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );

    Widget updateButtonsWidget = Container();

    if (userPermission.isDoctor) {
      updateButtonsWidget = Row(
        children: <Widget>[
          deleteButton,
          saveButton,
        ],
      );
    }

    Widget rowWidget = Column(
      children: <Widget>[
        nameTextField,
        dateTextField,
        commentTextField,
        updateButtonsWidget,
      ],
    );

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 80,
        ),
        child: rowWidget,
      ),
    );
  }
}
