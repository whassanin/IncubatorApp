import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';

class ConsumableRowWidget extends StatefulWidget {
  final Consumable consumable;
  final bool isPatientConsumableNurse;
  final bool isNurse;
  ConsumableRowWidget({this.consumable, this.isPatientConsumableNurse,this.isNurse});
  @override
  _ConsumableRowWidgetState createState() => _ConsumableRowWidgetState();
}

class _ConsumableRowWidgetState extends State<ConsumableRowWidget> {
  bool isSelected = false;

  Widget row() {
    List<PatientConsumableNurse> selectedList = patientConsumableNurseModel
        .patientConsumableNurseList
        .where((pa) => pa.consumableId == widget.consumable.id)
        .toList();

    if (selectedList.length > 0) {
      isSelected = true;
    }

    Widget rowData = Row(
      children: <Widget>[
        Text('Id: ' + widget.consumable.id.toString()),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Container(child: Text('Name: ' + widget.consumable.name))),
        (widget.isPatientConsumableNurse
            ? Checkbox(
          value: isSelected,
          onChanged: (b) {
            isSelected = b;
            patientConsumableNurseModel.setConsumableId(widget.consumable.id);
            patientConsumableNurseModel.create();
          },
        )
            : Container())
      ],
    );

    Widget rowContainer = Container(
      height: 50,
      child: Padding(padding: const EdgeInsets.only(left: 10), child: rowData),
    );

    Widget rowCard = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: rowContainer,
    );

    return GestureDetector(
      onTap: () {
        if (widget.isPatientConsumableNurse) {
        } else {

        }

        /*incubatorModel.editIncubator(widget.incubator);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditIncubatorScreen(),
          ),
        );*/
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        child: rowCard,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return row();
  }
}
