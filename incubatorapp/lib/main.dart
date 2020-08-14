import 'package:flutter/material.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/billsmodel.dart';
import 'package:incubatorapp/scopedmodels/conditionmodel.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/scopedmodels/doctorshiftmodel.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/scopedmodels/analysismodel.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/scopedmodels/nurseshiftmodel.dart';
import 'package:incubatorapp/scopedmodels/patientanalysismodel.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/screens/analysisscreen/editpatientanalysisscreen.dart';
import 'package:incubatorapp/screens/analysisscreen/newpatientanalysisscreen.dart';
import 'package:incubatorapp/screens/billscreen/billdetailscreen.dart';
import 'package:incubatorapp/screens/consumablescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/screens/doctorscreen/doctorprofilescreen.dart';
import 'package:incubatorapp/screens/doctorscreen/newdoctorscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/editincubatorscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/screens/medicinescreen/newpatientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/nursescreen/newnursescreen.dart';
import 'package:incubatorapp/screens/nursescreen/nurseprofilescreen.dart';
import 'package:incubatorapp/screens/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/newpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientdetailscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';

import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';
import 'package:incubatorapp/screens/analysisscreen/patientanalysisscreen.dart';
import 'package:incubatorapp/screens/shiftscreen/newshiftscreen.dart';
import 'package:incubatorapp/screens/shiftscreen/shiftscreen.dart';
import 'package:incubatorapp/screens/xrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/screens/xrayscreen/patientxrayscreen.dart';
import 'package:incubatorapp/screens/medicinescreen/patientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/consumablescreen/patientconsumablenursescreen.dart';

// basic Data
IncubatorModel incubatorModel = new IncubatorModel();
ConditionModel conditionModel = ConditionModel();
AnalysisModel analysisModel = new AnalysisModel();
XRayModel xRayModel = new XRayModel();
MedicineModel medicineModel = new MedicineModel();
ConsumableModel consumableModel = new ConsumableModel();
ShiftModel shiftModel = new ShiftModel();

UserModel userModel = new UserModel();
DoctorModel doctorModel = new DoctorModel();
NurseModel nurseModel = new NurseModel();

// 1 to many
PatientModel patientModel = new PatientModel();
BillModel billModel = new BillModel();
StatusModel statusModel = new StatusModel();

// many to many
PatientAnalysisModel patientAnalysisModel = new PatientAnalysisModel();
PatientXRayModel patientXRayModel = new PatientXRayModel();
PatientMedicineDoctorModel patientMedicineDoctorModel = new PatientMedicineDoctorModel();
PatientConsumableNurseModel patientConsumableNurseModel = new PatientConsumableNurseModel();

DoctorShiftModel doctorShiftModel = new DoctorShiftModel();
NurseShiftModel nurseShiftModel = new NurseShiftModel();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    conditionModel.readAll();
    analysisModel.readAll();
    xRayModel.readAll();
    medicineModel.readAll();
    consumableModel.readAll();
    shiftModel.readAll();

    UserPermission userPermission = new UserPermission();
    userPermission.setPermission(UserType.doctor);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        NewIncubatorScreen.routeName:(context)=>NewIncubatorScreen(),
        EditIncubatorScreen.routeName:(context)=>EditIncubatorScreen(),

        PatientAnalysisScreen.routeName:(context)=>PatientAnalysisScreen(),
        NewPatientAnalysisScreen.routeName:(context)=>NewPatientAnalysisScreen(),
        EditPatientAnalysisScreen.routeName:(context)=>EditPatientAnalysisScreen(),

        PatientXRayScreen.routeName:(context)=>PatientXRayScreen(),
        NewPatientXRayScreen.routeName:(context)=>NewPatientXRayScreen(),

        PatientMedicineDoctorScreen.routeName:(context)=>PatientMedicineDoctorScreen(),
        NewPatientMedicineDoctorScreen.routeName:(context)=>NewPatientMedicineDoctorScreen(),

        PatientConsumableNurseScreen.routeName:(context)=>PatientConsumableNurseScreen(),
        NewPatientConsumableNurseScreen.routeName:(context)=>NewPatientConsumableNurseScreen(),

        PatientDetailScreen.routeName:(context)=>PatientDetailScreen(),
        BillDetailScreen.routeName:(context)=>BillDetailScreen()
      },
      home: DoctorProfileScreen(userPermission: userPermission,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
