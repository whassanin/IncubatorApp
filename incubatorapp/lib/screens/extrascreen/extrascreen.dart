import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/extramodel.dart';
import 'package:incubatorapp/screens/extrascreen/newextrascreen.dart';
import 'package:incubatorapp/widgets/List/extralistwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class ExtraScreen extends StatelessWidget {
  static const routeName = '/extrascreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ExtraModel>(
      model: extraModel,
      child: ScopedModelDescendant<ExtraModel>(
        builder: (BuildContext context, Widget childWidget,
            ExtraModel incubatorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Extra List', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              actions: <Widget>[
                (userPermission.isAccountant
                    ? IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewExtraScreen(),
                            ),
                          );
                        },
                      )
                    : Container())
              ],
            ),
            body: ExtraListWidget(
              extraList: extraModel.extraList,
            ),
          );
        },
      ),
    );
  }
}
