import 'package:flutter/material.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:incubatorapp/widgets/row/xrayrowwidget.dart';
import 'package:incubatorapp/models/patient.dart';

class XRayListWidget extends StatefulWidget {
  final Patient patient;
  final List<XRay> xRayList;
  final UserPermission userPermission;
  XRayListWidget({this.patient,this.xRayList, this.userPermission});

  @override
  _XRayListWidgetState createState() => _XRayListWidgetState();
}

class _XRayListWidgetState extends State<XRayListWidget> {
  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.xRayList != null) {
      if (widget.xRayList.length > 0) {
        currentWidget = ListView.builder(
          itemCount: widget.xRayList.length,
          itemBuilder: (BuildContext context, int index) {
            return XRayRowWidget(
              xRay: widget.xRayList[index],
              userPermission: widget.userPermission,
            );
          },
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No XRay(s) Available'),
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
