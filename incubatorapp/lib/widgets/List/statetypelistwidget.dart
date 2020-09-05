import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/statetype.dart';
import 'package:incubatorapp/widgets/row/statetyperowwidget.dart';

class StateTypeListWidget extends StatefulWidget {
  final List<StateType> stateTypeList;
  StateTypeListWidget({this.stateTypeList});
  @override
  _StateListWidgetState createState() => _StateListWidgetState();
}

class _StateListWidgetState extends State<StateTypeListWidget> {
  Widget _getList() {
    Widget current = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.stateTypeList == null) {
      return current;
    }
    else if(widget.stateTypeList!=null){
      if(widget.stateTypeList.length == 0){
        return current;
      }
    }

    return ListView.builder(
      itemCount: widget.stateTypeList.length,
      itemBuilder: (BuildContext context, int index) {
        return StateTypeRowWidget(stateType: widget.stateTypeList[index],);
      },
    );
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
