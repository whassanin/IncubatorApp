import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/screens/statusscreen/newstatusscreen.dart';
import 'package:incubatorapp/widgets/List/statuslistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class StatusScreen extends StatelessWidget {
  static const routeName = '/statusscreen';

  final Patient patient;
  final UserPermission userPermission;
  StatusScreen({this.patient, this.userPermission});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: statusModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, StatusModel statusModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Status History',style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                (userPermission.isNurse == true
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewStatusScreen(patient: patient,),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: StatusListWidget(
              patient: patient,
              statusList: statusModel.statusList,
            ),
          );
        },
      ),
    );
  }
}
