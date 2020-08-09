import 'package:flutter/material.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/consumablerowwidget.dart';

class ConsumableListWidget extends StatefulWidget {
  final Patient patient;
  final List<Consumable> consumableList;
  final UserPermission userPermission;
  ConsumableListWidget(
      {this.patient, this.consumableList, this.userPermission});

  @override
  _ConsumableListWidgetState createState() => _ConsumableListWidgetState();
}

class _ConsumableListWidgetState extends State<ConsumableListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.consumableList != null) {
      if (widget.consumableList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.consumableList.length,
          itemBuilder: (BuildContext context, int index) {
            return ConsumableRowWidget(
              patient: widget.patient,
              consumable: widget.consumableList[index],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Consumable(s) Available'),
          ),
        );
      }
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return _getList();
  }
}
