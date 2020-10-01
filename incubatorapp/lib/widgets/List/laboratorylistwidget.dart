import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/laboratoryscreen/searchlaboratoryscreen.dart';
import 'package:incubatorapp/widgets/row/laboratoryrowwidget.dart';

class LaboratoryListWidget extends StatefulWidget {
  final List<Laboratory> laboratoryList;
  LaboratoryListWidget({
    this.laboratoryList,
  });

  @override
  _LaboratoryListWidgetState createState() => _LaboratoryListWidgetState();
}

class _LaboratoryListWidgetState extends State<LaboratoryListWidget> {
  void clearSearch() {
    laboratoryModel.setSearchName('');
    laboratoryModel.readAll();
  }

  Widget searchTextField() {
    bool isSearch = false;

    String search = 'Search here...';

    if (laboratoryModel.searchName != null) {
      if (laboratoryModel.searchName.isNotEmpty) {
        search = laboratoryModel.searchName;
        isSearch = true;
      }
    }

    Widget displayTextContainer = Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 25.0, bottom: 8.0),
        child: Text(
          search,
          textAlign: TextAlign.left,
          style: TextStyle(),
        ),
      ),
    );

    Widget displayTextGestureDetector = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchLaboratoryScreen.routeName);
      },
      child: displayTextContainer,
    );

    Widget displayTextIconButton = IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () {
        isSearch = false;
        clearSearch();
      },
    );

    if (isSearch == false) {
      displayTextIconButton = Container();
    }

    Widget displayTextRow = Row(
      children: <Widget>[
        Expanded(
          child: displayTextGestureDetector,
        ),
        displayTextIconButton,
      ],
    );

    Widget displayTextRowContainer = Container(
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          border: Border.all(width: 1)),
      child: displayTextRow,
    );

    Widget searchTF = Padding(
      padding: const EdgeInsets.all(10.0),
      child: displayTextRowContainer,
    );

    return searchTF;
  }

  Widget _getList() {
    Widget currentWidget = Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );

    if (widget.laboratoryList != null) {
      if (widget.laboratoryList.length > 0) {
        currentWidget = Column(
          children: <Widget>[
            searchTextField(),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.laboratoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return LaboratoryRowWidget(
                    patient: patientModel.currentPatient,
                    laboratory: widget.laboratoryList[index],
                  );
                },
              ),
            ),
          ],
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Laboratory(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Laboratory(s) Available'),
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
            clearSearch();
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
