import 'package:flutter/material.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
class IncubatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IncubatorModel incubatorModel = new IncubatorModel();


    return Scaffold(
      appBar: AppBar(
        title: Text('Incubator List'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('Get'),
            onPressed: (){
              incubatorModel.readAll();
            },
          ),
        ),
      ),
    );
  }
}
