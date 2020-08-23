import 'package:flutter/material.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/widgets/form/doctorformwidget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewDoctorScreen extends StatelessWidget {
  static const routeName = '/newdoctorscreen';

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: doctorModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget childWidget,
            DoctorModel doctorModel) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              title: Text('Register Doctor',style: TextStyle(color: Colors.white)),
            ),
            body: DoctorFormWidget(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
