import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/widgets/row/conditionrowwidget.dart';

class ConditionListWidget extends StatefulWidget {
  final Patient patient;
  final List<Condition> conditionList;
  ConditionListWidget({this.patient,this.conditionList,});

  @override
  _ConditionListWidgetState createState() => _ConditionListWidgetState();
}

class _ConditionListWidgetState extends State<ConditionListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.conditionList != null) {
      if (widget.conditionList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.conditionList.length,
          itemBuilder: (BuildContext context, int index) {
            return ConditionRowWidget(
              patient: widget.patient,
              condition: widget.conditionList[index],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Condition(s) Available'),
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

    if (userPermission.isDoctor) {
      currentWidget = Stack(
        children: <Widget>[positionList, positionSaveButton],
      );
    }


    return currentWidget;
  }
}
