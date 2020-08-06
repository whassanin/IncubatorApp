import 'package:flutter/material.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/widgets/row/consumablerowwidget.dart';

class ConsumableListWidget extends StatefulWidget {
  final List<Consumable> consumableList;
  final bool isPatientConsumableNurse;
  ConsumableListWidget({this.consumableList, this.isPatientConsumableNurse});

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
              consumable: widget.consumableList[index],
              isPatientConsumableNurse: widget.isPatientConsumableNurse,
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
