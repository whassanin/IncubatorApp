import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_push/push.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/accountantmodel.dart';
import 'package:incubatorapp/scopedmodels/billmodel.dart';
import 'package:incubatorapp/scopedmodels/conditionmodel.dart';
import 'package:incubatorapp/scopedmodels/consumablemodel.dart';
import 'package:incubatorapp/scopedmodels/creditcardmodel.dart';
import 'package:incubatorapp/scopedmodels/doctormodel.dart';
import 'package:incubatorapp/scopedmodels/doctorshiftmodel.dart';
import 'package:incubatorapp/scopedmodels/extramodel.dart';
import 'package:incubatorapp/scopedmodels/incubatormodel.dart';
import 'package:incubatorapp/scopedmodels/laboratorymodel.dart';
import 'package:incubatorapp/scopedmodels/medicinemodel.dart';
import 'package:incubatorapp/scopedmodels/nursemodel.dart';
import 'package:incubatorapp/scopedmodels/nurseshiftmodel.dart';
import 'package:incubatorapp/scopedmodels/patientconsumablenursemodel.dart';
import 'package:incubatorapp/scopedmodels/patientextramodel.dart';
import 'package:incubatorapp/scopedmodels/patientlaboratorymodel.dart';
import 'package:incubatorapp/scopedmodels/patientmedicinedoctormodel.dart';
import 'package:incubatorapp/scopedmodels/patientmodel.dart';
import 'package:incubatorapp/scopedmodels/patientxraysmodel.dart';
import 'package:incubatorapp/scopedmodels/reportproblemmodel.dart';
import 'package:incubatorapp/scopedmodels/shiftmodel.dart';
import 'package:incubatorapp/scopedmodels/statetypemodel.dart';
import 'package:incubatorapp/scopedmodels/statusmodel.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:incubatorapp/screens/accountantscreen/accountantprofilescreen.dart';
import 'package:incubatorapp/screens/billscreen/billdetailscreen.dart';
import 'package:incubatorapp/screens/billscreen/billscreen.dart';
import 'package:incubatorapp/screens/consumablescreen/searchconsumablescreen.dart';
import 'package:incubatorapp/screens/contactusscreen/contactusscreen.dart';
import 'package:incubatorapp/screens/creditcardscreen/creditcardscreen.dart';
import 'package:incubatorapp/screens/creditcardscreen/editcreditcardscreen.dart';
import 'package:incubatorapp/screens/creditcardscreen/newcreditcardscreen.dart';
import 'package:incubatorapp/screens/doctorscreen/doctorprofilescreen.dart';
import 'package:incubatorapp/screens/doctorscreen/editdoctorscreen.dart';
import 'package:incubatorapp/screens/doctorscreen/newdoctorscreen.dart';
import 'package:incubatorapp/screens/doctorshiftscreen/editdoctorshiftscreen.dart';
import 'package:incubatorapp/screens/doctorshiftscreen/newdoctorshiftscreen.dart';
import 'package:incubatorapp/screens/historyscreen/historyscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/editincubatorscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/incubatorscreen.dart';
import 'package:incubatorapp/screens/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/screens/laboratoryscreen/searchlaboratoryscreen.dart';
import 'package:incubatorapp/screens/loginscreen/forgetpasswordscreen.dart';
import 'package:incubatorapp/screens/loginscreen/signinscreen.dart';
import 'package:incubatorapp/screens/loginscreen/usertypescreen.dart';
import 'package:incubatorapp/screens/medicinescreen/searchmedicinescreen.dart';
import 'package:incubatorapp/screens/nursescreen/editnursescreen.dart';
import 'package:incubatorapp/screens/nursescreen/newnursescreen.dart';
import 'package:incubatorapp/screens/nursescreen/nurseprofilescreen.dart';
import 'package:incubatorapp/screens/nurseshiftscreen/editnurseshiftscreen.dart';
import 'package:incubatorapp/screens/nurseshiftscreen/newnurseshiftscreen.dart';
import 'package:incubatorapp/screens/patientconsumablenursescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/screens/patientconsumablenursescreen/patientconsumablenursescreen.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/editpatientlaboratoryscreen.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/newpatientlaboratoryscreen.dart';
import 'package:incubatorapp/screens/patientlaboratoryscreen/patientlaboratoryscreen.dart';
import 'package:incubatorapp/screens/patientmedicinedoctorscreen/newpatientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/patientmedicinedoctorscreen/patientmedicinedoctorscreen.dart';
import 'package:incubatorapp/screens/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/newpatientscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientdetailscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/screens/patientscreen/patientprofilescreen.dart';
import 'package:incubatorapp/screens/patientxrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/screens/patientxrayscreen/patientxrayscreen.dart';
import 'package:incubatorapp/screens/reportscreen/reportscreen.dart';
import 'package:incubatorapp/screens/statusscreen/newstatusscreen.dart';
import 'package:incubatorapp/screens/welcomescreen.dart';
import 'package:huawei_push/constants/channel.dart' as Channel;
import 'package:incubatorapp/screens/xrayscreen/searchxrayscreen.dart';
import 'package:incubatorapp/util/basicdata.dart';

// basic Data
IncubatorModel incubatorModel = new IncubatorModel();
ConditionModel conditionModel = ConditionModel();
LaboratoryModel laboratoryModel = new LaboratoryModel();
XRayModel xRayModel = new XRayModel();
MedicineModel medicineModel = new MedicineModel();
ConsumableModel consumableModel = new ConsumableModel();
ShiftModel shiftModel = new ShiftModel();
ExtraModel extraModel = new ExtraModel();
StateTypeModel stateTypeModel = new StateTypeModel();

UserModel userModel = new UserModel();
DoctorModel doctorModel = new DoctorModel();
NurseModel nurseModel = new NurseModel();
AccountantModel accountantModel = new AccountantModel();
ReportProblemModel reportProblemModel = new ReportProblemModel();

// 1 to many
PatientModel patientModel = new PatientModel();
BillModel billModel = new BillModel();
StatusModel statusModel = new StatusModel();
CreditCardModel creditCardModel = new CreditCardModel();

// many to many
PatientLaboratoryModel patientLaboratoryModel = new PatientLaboratoryModel();
PatientXRayModel patientXRayModel = new PatientXRayModel();
PatientMedicineDoctorModel patientMedicineDoctorModel =
    new PatientMedicineDoctorModel();
PatientConsumableNurseModel patientConsumableNurseModel =
    new PatientConsumableNurseModel();
PatientExtraModel patientExtraModel = new PatientExtraModel();

DoctorShiftModel doctorShiftModel = new DoctorShiftModel();
NurseShiftModel nurseShiftModel = new NurseShiftModel();

UserPermission userPermission = new UserPermission();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    incubatorModel.readAll();
    conditionModel.readAll();
    shiftModel.readAll();
    laboratoryModel.readAll();
    xRayModel.readAll();
    medicineModel.readAll();
    consumableModel.readAll();
    extraModel.readAll();
    stateTypeModel.readAll();

    //userPermission.setPermission(UserType.doctor);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        EditPatientLaboratoryScreen.routeName: (context) =>
            EditPatientLaboratoryScreen(),
        NewPatientLaboratoryScreen.routeName: (context) =>
            NewPatientLaboratoryScreen(),
        PatientLaboratoryScreen.routeName: (context) =>
            PatientLaboratoryScreen(),
        BillDetailScreen.routeName: (context) => BillDetailScreen(),
        BillScreen.routeName: (context) => BillScreen(),
        NewPatientConsumableNurseScreen.routeName: (context) =>
            NewPatientConsumableNurseScreen(),
        PatientConsumableNurseScreen.routeName: (context) =>
            PatientConsumableNurseScreen(),
        ContactUsScreen.routeName: (context) => ContactUsScreen(),
        CreditCardScreen.routeName: (context) => CreditCardScreen(),
        EditCreditCardScreen.routeName: (context) => EditCreditCardScreen(),
        NewCreditCardScreen.routeName: (context) => NewCreditCardScreen(),
        DoctorProfileScreen.routeName: (context) => DoctorProfileScreen(),
        EditDoctorScreen.routeName: (context) => EditDoctorScreen(),
        NewDoctorScreen.routeName: (context) => NewDoctorScreen(),
        HistoryScreen.routeName: (context) => HistoryScreen(),
        EditIncubatorScreen.routeName: (context) => EditIncubatorScreen(),
        IncubatorScreen.routeName: (context) => IncubatorScreen(false),
        NewIncubatorScreen.routeName: (context) => NewIncubatorScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        UserTypeScreen.routeName: (context) => UserTypeScreen(),
        NewPatientMedicineDoctorScreen.routeName: (context) =>
            NewPatientMedicineDoctorScreen(),
        PatientMedicineDoctorScreen.routeName: (context) =>
            PatientMedicineDoctorScreen(),
        EditNurseScreen.routeName: (context) => EditNurseScreen(),
        NewNurseScreen.routeName: (context) => NewNurseScreen(),
        NurseProfileScreen.routeName: (context) => NurseProfileScreen(),
        EditPatientScreen.routeName: (context) => EditPatientScreen(),
        NewPatientScreen.routeName: (context) => NewPatientScreen(),
        PatientDetailScreen.routeName: (context) => PatientDetailScreen(),
        PatientListScreen.routeName: (context) => PatientListScreen(),
        PatientProfileScreen.routeName: (context) => PatientProfileScreen(),
        ReportScreen.routeName: (context) => ReportScreen(),
        EditDoctorShiftScreen.routeName: (context) => EditDoctorShiftScreen(),
        EditNurseShiftScreen.routeName: (context) => EditNurseShiftScreen(),
        NewDoctorShiftScreen.routeName: (context) => NewDoctorShiftScreen(),
        NewNurseShiftScreen.routeName: (context) => EditNurseShiftScreen(),
        NewStatusScreen.routeName: (context) => NewStatusScreen(),
        PatientXRayScreen.routeName: (context) => PatientXRayScreen(),
        NewPatientXRayScreen.routeName: (context) => NewPatientXRayScreen(),
        SearchLaboratoryScreen.routeName: (context) => SearchLaboratoryScreen(),
        SearchXRayScreen.routeName: (context) => SearchXRayScreen(),
        SearchMedicineScreen.routeName: (context) => SearchMedicineScreen(),
        SearchConsumableScreen.routeName: (context) => SearchConsumableScreen()
      },
      home: MyHomePage(
        title: 'Utilities',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Isolate _isolate;
  bool _running = false;
  static int _counter = 0;
  String notification = '';
  ReceivePort _receivePort;
  BasicData bd = new BasicData();

  void _start() async {
    _running = true;
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_checkTimer, _receivePort.sendPort);
    _receivePort.listen(_handleMessage, onDone: () {
      print('Done');
    });
  }

  static void _checkTimer(SendPort sendPort) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      String msg = 'Notification' + _counter.toString();
      print('SEND:' + msg);
      sendPort.send(msg);
    });
  }

  void _handleMessage(dynamic data) {
    print('RECEIVED: ' + data);
    setState(() {
      notification = data;
    });
  }

  void _stop() {
    if (_isolate != null) {
      setState(() {
        _running = false;
        notification = '';
      });
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void createBasicData() {

/*
    print('Incubator List:'+incubatorModel.incubatorList.length.toString());*/

/*
    print('Condition List:'+conditionModel.conditionList.length.toString());*/

/*
    print('Shift List:'+shiftModel.shiftList.length.toString());*/

/*
    print('Laboratory List:'+laboratoryModel.laboratoryList.length.toString());*/

/*
    print('XRay List:'+xRayModel.xRayList.length.toString());*/

/*
    print('Medicine List:'+medicineModel.medicineList.length.toString());*/

/*
    print('Consumable List:'+consumableModel.consumableList.length.toString());*/

/*
    print('Extra List:'+extraModel.extraList.length.toString());*/

/*
    print('State Type List:'+stateTypeModel.stateTypeList.length.toString());*/
  }

  Widget buttonWidget(String title, VoidCallback fun) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text(title),
            onPressed: () {
              fun();
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
/*    Container(
      child: Text(notification),
    ),*/

    //onPressed: _running ? _stop : _start
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buttonWidget('Add Incubator List',bd.addIncubatorData),
            buttonWidget('Add Condition List',bd.addConditionData),
            buttonWidget('Add Shift List',bd.addShiftData),
            buttonWidget('Add Laboratory List',bd.addLaboratoryData),
            buttonWidget('Add XRay List',bd.addXRayData),
            buttonWidget('Add Medicine List',bd.addMedicineData),
            buttonWidget('Add Consumable List',bd.addConsumableData),
            buttonWidget('Add Extra List',bd.addExtraData),
            buttonWidget('Add State Type List',bd.addStateTypeData),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        //onPressed: createBasicData,
        tooltip: _running ? 'Timer Stop' : 'Timer Start',
        child: _running ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
