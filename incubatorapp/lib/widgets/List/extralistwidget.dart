import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/extra.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/widgets/row/extrarowwidget.dart';

class ExtraListWidget extends StatefulWidget {
  final Patient patient;
  final List<Extra> extraList;
  ExtraListWidget({this.patient,this.extraList,});

  @override
  _ExtraListWidgetState createState() => _ExtraListWidgetState();
}

class _ExtraListWidgetState extends State<ExtraListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.extraList != null) {
      if (widget.extraList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.extraList.length,
          itemBuilder: (BuildContext context, int index) {
            return ExtraRowWidget(
              patient: widget.patient,
              extra: widget.extraList[index],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Extra(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('Loading...'),
        ),
      );
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = _getList();

    Widget positionList = Positioned(
        child: Align(alignment: Alignment.topCenter, child: _getList()));

    Widget positionSaveButton = Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (userPermission.isDoctor || userPermission.isNurse) {
      currentWidget = Stack(
        children: <Widget>[positionList, positionSaveButton],
      );
    }


    return currentWidget;
  }
}
