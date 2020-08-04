import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/widgets/bottomnavigator/bottomnavigatorwidget.dart';
import 'package:incubatorapp/widgets/row/patientdetailrowwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientScreen extends StatelessWidget {
  static const routeName = '/patientscreen';
  @override
  Widget build(BuildContext context) {


    return Center(
      child: Container(
        child: Text('List All Patient Screen'),
      ),
    );
  }
}
