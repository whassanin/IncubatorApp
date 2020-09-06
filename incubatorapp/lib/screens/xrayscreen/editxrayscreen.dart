import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/widgets/form/xrayformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class EditXRayScreen extends StatelessWidget {
  static const routeName = '/editxrayscreen';

  EditXRayScreen();

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
              title: Text('Edit XRay Screen',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: XRayFormWidget(
              isEdit: true,
            ),
          );
        },
      ),
    );
  }
}
