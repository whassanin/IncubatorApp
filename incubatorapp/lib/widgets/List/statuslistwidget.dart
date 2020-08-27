import 'package:flutter/material.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/widgets/row/statusrowwidget.dart';

class StatusListWidget extends StatefulWidget {
  final Patient patient;
  final List<Status> statusList;
  final UserPermission userPermission;
  StatusListWidget({this.patient,this.statusList, this.userPermission});

  @override
  _StatusListWidgetState createState() => _StatusListWidgetState();
}

class _StatusListWidgetState extends State<StatusListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.statusList != null) {
      if (widget.statusList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.statusList.length,
          itemBuilder: (BuildContext context, int index) {
            return StatusRowWidget(
              status: widget.statusList[index],
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Status(s) Available'),
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

    return currentWidget;
  }
}
