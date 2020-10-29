import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/widgets/search/searchxraywidget.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchXRayScreen extends StatelessWidget {
  static const routeName = '/searchxrayscreen';

  SearchXRayScreen();

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
              title: Text(
                'Search XRay Screen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                child: SearchXRayWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
