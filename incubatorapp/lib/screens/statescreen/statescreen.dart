import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/scopedmodels/statetypemodel.dart';
import 'package:incubatorapp/screens/statescreen/newstatescreen.dart';
import 'package:incubatorapp/widgets/List/statetypelistwidget.dart';

import 'package:scoped_model/scoped_model.dart';

class StateTypeScreen extends StatelessWidget {
  static const routeName = '/statescreen';

  final bool isPatient;
  StateTypeScreen(this.isPatient);

  @override
  Widget build(BuildContext context) {

    Widget currentWidget = ScopedModel<StateTypeModel>(
      model: stateTypeModel,
      child: ScopedModelDescendant<StateTypeModel>(
        builder: (BuildContext context, Widget childWidget,
            StateTypeModel stateTypeModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('State List',style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewStateTypeScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: StateTypeListWidget(
              stateTypeList: stateTypeModel.stateTypeList,
            ),
          );
        },
      ),
    );

    if(this.isPatient){
      currentWidget = ScopedModel<PatientModel>(
        model: patientModel,
        child: ScopedModelDescendant<PatientModel>(
          builder: (BuildContext context, Widget childWidget,
              PatientModel patientModel) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.white,
                ),
                title: Text('State List',style: TextStyle(color: Colors.white)),
                centerTitle: true,
              ),
              body:StateTypeListWidget(
                stateTypeList: stateTypeModel.stateTypeList,
              ),
            );
          },
        ),
      );
    }


    return currentWidget;
  }
}
