import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/widgets/form/xrayformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewXRayScreen extends StatelessWidget {
  static const routeName = '/newxrayscreen';

  NewXRayScreen();

  @override
  Widget build(BuildContext context) {
    xRayModel.createXRay();
    return ScopedModel<XRayModel>(
      model: xRayModel,
      child: ScopedModelDescendant<XRayModel>(
        builder: (BuildContext context, Widget childWidget,
            XRayModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('New XRay Screen',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: XRayFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
