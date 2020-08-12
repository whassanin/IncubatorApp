import 'package:flutter/material.dart';
import 'package:incubatorapp/models/shift.dart';
import 'package:incubatorapp/widgets/row/shiftrowwidget.dart';

class ShiftListWidget extends StatefulWidget {
  final List<Shift> shiftList;
  ShiftListWidget({this.shiftList});

  @override
  _ShiftListWidgetState createState() => _ShiftListWidgetState();
}

class _ShiftListWidgetState extends State<ShiftListWidget> {
  Widget getItem() {

    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if(widget.shiftList!=null){
      if(widget.shiftList.length > 0){
        currentWidget = ListView.builder(
          itemCount: widget.shiftList.length,
          itemBuilder: (BuildContext context, int i) {
            return ShiftRowWidget(
              shift: widget.shiftList[i],
            );
          },
        );
      }else {
        currentWidget = Center(
          child: Container(
            child: Text('No Shift(s) Available'),
          ),
        );
      }
    }else {
      currentWidget = Center(
        child: Container(
          child: Text('No Shift(s) Available'),
        ),
      );
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
    return getItem();
  }
}
