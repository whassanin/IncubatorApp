import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/views/medicine/medicinescreen/searchmedicinescreen.dart';
import 'package:incubatorapp/widgets/row/medicinerowwidget.dart';

class MedicineListWidget extends StatefulWidget {
  final List<Medicine> medicineList;
  MedicineListWidget({
    this.medicineList,
  });

  @override
  _MedicineListWidgetState createState() => _MedicineListWidgetState();
}

class _MedicineListWidgetState extends State<MedicineListWidget> {
  void clearSearch() {
    medicineModel.setSearchName('');
    medicineModel.readAll();
  }

  Widget searchTextField() {
    bool isSearch = false;

    String search = 'Search here...';

    if (medicineModel.searchName != null) {
      if (medicineModel.searchName.isNotEmpty) {
        search = medicineModel.searchName;
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
        Navigator.pushNamed(context, SearchMedicineScreen.routeName);
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
          itemCount: widget.medicineList.length,
          itemBuilder: (BuildContext context, int index) {
            return MedicineRowWidget(
              patient: patientModel.currentPatient,
              medicine: widget.medicineList[index],
            );
          },
        ),
      ),
    );

    if(userPermission.isAccountant){
      currentList = Expanded(
        child: ListView.builder(
          itemCount: widget.medicineList.length,
          itemBuilder: (BuildContext context, int index) {
            return MedicineRowWidget(
              patient: patientModel.currentPatient,
              medicine: widget.medicineList[index],
            );
          },
        ),
      );
    }

    if (widget.medicineList != null) {
      if (widget.medicineList.length > 0) {
        currentWidget = Column(
          children: <Widget>[
            searchTextField(),
            currentList
          ],
        );
      } else {
        currentWidget = Center(
          child: Container(
            child: Text('No Medicine(s) Available'),
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
