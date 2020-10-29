import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/views/shift/shiftscreen/newshiftscreen.dart';
import 'package:incubatorapp/widgets/List/shiftlistwidget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:incubatorapp/main.dart';

class ShiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ShiftModel>(
      model: shiftModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context,Widget child,ShiftModel shiftModel){
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Shift Screen',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewShiftScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: ShiftListWidget(
              shiftList: shiftModel.shiftList,
            ),
          );
        },
      ),
    );
  }
}
