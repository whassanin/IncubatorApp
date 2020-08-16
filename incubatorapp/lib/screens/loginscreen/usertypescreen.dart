import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/form/usertypeformwidget.dart';

class UserTypeScreen extends StatelessWidget {
  static const routeName = '/usertypescreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: UserTypeFromWidget(),
    );
  }
}
