import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/views/xray/xrayscreen/newxrayscreen.dart';
import 'package:incubatorapp/widgets/List/xraylistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class XRayScreen extends StatelessWidget {
  static const routeName = '/xrayscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<XRayModel>(
      model: xRayModel,
      child: ScopedModelDescendant<XRayModel>(
        builder: (BuildContext context, Widget childWidget,
            XRayModel xRayModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title:
              Text('XRay List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewXRayScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: XRayListWidget(
              xRayList: xRayModel.xRayList,
            ),
          );
        },
      ),
    );
  }
}
