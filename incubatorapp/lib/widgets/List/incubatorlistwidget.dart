import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
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


    if(widget.incubatorList!=null){
      if(widget.incubatorList.length > 0){
        current = ListView.builder(
          itemCount: widget.incubatorList.length,
          itemBuilder: (BuildContext context, int index) {
            return IncubatorRowWidget(
              incubator: widget.incubatorList[index],
            );
          },
        );
      }else {

      }
    }else {

    }

    return current;
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
            height: (userPermission.isDoctor||userPermission.isNurse?70:0),
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
            patientModel.update();
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
