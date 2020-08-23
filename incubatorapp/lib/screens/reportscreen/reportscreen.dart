import 'package:flutter/material.dart';
import 'package:incubatorapp/widgets/form/reportformwidget.dart';

class ReportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text('Report Screen',style: TextStyle(color: Colors.white),),
      ),
      body: ReportFormWidget()
    );
  }
}
