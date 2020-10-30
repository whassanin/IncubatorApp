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
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.incubatorList != null) {
      if (widget.incubatorList.length > 0) {
        if (webPageModel.isWeb) {
          currentWidget = GridView.count(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 24 / 9,
            children: List.generate(
              widget.incubatorList.length,
              (index) {
                return IncubatorRowWidget(
                  incubator: widget.incubatorList[index],
                );
              },
            ),
          );
        } else {
          currentWidget = ListView.builder(
            itemCount: widget.incubatorList.length,
            itemBuilder: (BuildContext context, int index) {
              return IncubatorRowWidget(
                incubator: widget.incubatorList[index],
              );
            },
          );
        }
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Incubator(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Incubator(s) Available'),
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
            height:
                (userPermission.isDoctor || userPermission.isNurse ? 70 : 0),
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
