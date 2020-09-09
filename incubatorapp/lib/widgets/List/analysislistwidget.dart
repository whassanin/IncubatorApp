import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/screens/analysisscreen/searchanalysisscreen.dart';
import 'package:incubatorapp/widgets/row/analysisrowwidget.dart';

class AnalysisListWidget extends StatefulWidget {
  final Patient patient;
  final List<Analysis> analysisList;
  AnalysisListWidget({
    this.patient,
    this.analysisList,
  });

  @override
  _AnalysisListWidgetState createState() => _AnalysisListWidgetState();
}

class _AnalysisListWidgetState extends State<AnalysisListWidget> {
  void clearSearch() {
    analysisModel.setSearchName('');
    analysisModel.readAll();
  }

  Widget searchTextField() {
    bool isSearch = false;

    String search = 'Search here...';

    if (analysisModel.searchName != null) {
      if (analysisModel.searchName.isNotEmpty) {
        search = analysisModel.searchName;
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
        Navigator.pushNamed(context, SearchAnalysisScreen.routeName);
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

    if (widget.analysisList != null) {
      if (widget.analysisList.length > 0) {
        currentWidget = Column(
          children: <Widget>[
            searchTextField(),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.analysisList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnalysisRowWidget(
                    patient: widget.patient,
                    analysis: widget.analysisList[index],
                  );
                },
              ),
            ),
          ],
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Analysis(s) Available'),
          ),
        );
      }
    } else {
      currentWidget = Center(
        child: Container(
          child: Text('No Analysis(s) Available'),
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
            patientAnalysisModel.readByPatientId(widget.patient.userId);
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
