import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';

class PatientLaboratoryFormWidget extends StatefulWidget {
  final PatientLaboratory patientLaboratory;
  final Laboratory laboratory;
  PatientLaboratoryFormWidget({this.patientLaboratory, this.laboratory});
  @override
  _PatientLaboratoryFormWidgetState createState() =>
      _PatientLaboratoryFormWidgetState();
}

class _PatientLaboratoryFormWidgetState
    extends State<PatientLaboratoryFormWidget> {
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController dateTEC = new TextEditingController();
  TextEditingController resultTEC = new TextEditingController();

  String dateFormat() {
    String v = widget.patientLaboratory.createdDate.day.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.month.toString();
    v = v + '/' + widget.patientLaboratory.createdDate.year.toString();
    return v;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTEC.text = widget.laboratory.name;
    dateTEC.text = dateFormat();
    resultTEC.text = widget.patientLaboratory.result;
  }

  void save() async {
    bool isCheck = await patientLaboratoryModel.update();
    if (isCheck) {
      Navigator.pop(context);
    }
  }

  void delete() async{
    bool isCheck = await patientLaboratoryModel.delete();
    if (isCheck) {
      Navigator.pop(context);
    }
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
                labelText: 'Laboratory Name',
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

    Widget resultTextField = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          minLines: null,
          maxLines: null,
          expands: true,
          controller: resultTEC,
          readOnly: (userPermission.isDoctor?false:true),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            labelText: 'Result',
          ),
          validator: (v) {
            if (v.isEmpty) {
              return 'Required';
            }
            return null;
          },
          onChanged: (v) {
            patientLaboratoryModel.setResult(v);
          },
          onFieldSubmitted: (v) {
            patientLaboratoryModel.setResult(v);
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
              delete();
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
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () {
              save();
            },
          ),
        ),
      ),
    );

    Widget updateButtonsWidget = Container();

    if(userPermission.isDoctor){
      updateButtonsWidget = Row(
        children: <Widget>[
          deleteButton,
          saveButton,
        ],
      );
    }

    Widget rowWidget = Column(
      children: <Widget>[nameTextField,dateTextField, resultTextField, updateButtonsWidget],
    );

    return rowWidget;
  }
}
