import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/widgets/row/incubatorrowwidget.dart';

class IncubatorListWidget extends StatefulWidget {
  final IncubatorModel incubatorModel;
  IncubatorListWidget({this.incubatorModel});
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

    if (widget.incubatorModel.incubatorList == null) {
      return current;
    }
    else if(widget.incubatorModel.incubatorList!=null){
      if(widget.incubatorModel.incubatorList.length == 0){
        return current;
      }
    }

    return ListView.builder(
      itemCount: widget.incubatorModel.incubatorList.length,
      itemBuilder: (BuildContext context, int index) {
        return IncubatorRowWidget(incubator: widget.incubatorModel.incubatorList[index],);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getList();
  }
}
