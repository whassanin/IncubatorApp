import 'package:flutter/material.dart';
import 'package:incubatorapp/models/incubator.dart';
import 'package:incubatorapp/widgets/row/incubatorrowwidget.dart';

class IncubatorListWidget extends StatefulWidget {
  final List<Incubator> incubatorList;
  IncubatorListWidget({this.incubatorList});
  @override
  _IncubatorListWidgetState createState() => _IncubatorListWidgetState();
}

class _IncubatorListWidgetState extends State<IncubatorListWidget> {
  Widget _getList() {
    Widget current = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.incubatorList == null) {
      return current;
    }
    else if(widget.incubatorList!=null){
      if(widget.incubatorList.length == 0){
        return current;
      }
    }

    return ListView.builder(
      itemCount: widget.incubatorList.length,
      itemBuilder: (BuildContext context, int index) {
        return IncubatorRowWidget(incubator: widget.incubatorList[index],);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getList();
  }
}
