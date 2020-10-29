import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/views/consumable/consumablescreen/searchconsumablescreen.dart';
import 'package:incubatorapp/widgets/row/consumablerowwidget.dart';

class ConsumableListWidget extends StatefulWidget {
  final List<Consumable> consumableList;
  ConsumableListWidget({
    this.consumableList,
  });

  @override
  _ConsumableListWidgetState createState() => _ConsumableListWidgetState();
}

class _ConsumableListWidgetState extends State<ConsumableListWidget> {
  void clearSearch() {
    consumableModel.setSearchName('');
    consumableModel.readAll();
  }

  Widget searchTextField() {
    bool isSearch = false;

    String search = 'Search here...';

    if (consumableModel.searchName != null) {
      if (consumableModel.searchName.isNotEmpty) {
        search = consumableModel.searchName;
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
        Navigator.pushNamed(context, SearchConsumableScreen.routeName);
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

    Widget currentList = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: ListView.builder(
          itemCount: widget.consumableList.length,
          itemBuilder: (BuildContext context, int index) {
            return ConsumableRowWidget(
              patient: patientModel.currentPatient,
              consumable: widget.consumableList[index],
            );
          },
        ),
      ),
    );

    if (userPermission.isAccountant) {
      currentList = Expanded(
        child: ListView.builder(
          itemCount: widget.consumableList.length,
          itemBuilder: (BuildContext context, int index) {
            return ConsumableRowWidget(
              patient: patientModel.currentPatient,
              consumable: widget.consumableList[index],
            );
          },
        ),
      );
    }

    if (widget.consumableList != null) {
      if (widget.consumableList.length > 0) {
        currentWidget = Column(
          children: <Widget>[
            searchTextField(),
            currentList,
          ],
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Consumable(s) Available'),
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

    if (userPermission.isNurse) {
      currentWidget = Stack(
        children: <Widget>[positionList, positionSaveButton],
      );
    }

    return currentWidget;
  }
}
