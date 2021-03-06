import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:incubatorapp/scopedmodels/webpagemodel.dart';
import 'package:incubatorapp/scopedmodels/xraymodel.dart';
import 'package:huawei_push/constants/channel.dart' as Channel;
import 'package:incubatorapp/util/basicdata.dart';
import 'package:incubatorapp/util/userdata.dart';
import 'package:incubatorapp/views/bill/billscreen/billdetailscreen.dart';
import 'package:incubatorapp/views/bill/billscreen/billscreen.dart';
import 'package:incubatorapp/views/consumable/consumablescreen/searchconsumablescreen.dart';
import 'package:incubatorapp/views/contactus/contactusscreen/contactusscreen.dart';
import 'package:incubatorapp/views/creditcard/creditcardscreen/creditcardscreen.dart';
import 'package:incubatorapp/views/creditcard/creditcardscreen/editcreditcardscreen.dart';
import 'package:incubatorapp/views/creditcard/creditcardscreen/newcreditcardscreen.dart';
import 'package:incubatorapp/views/doctor/doctorscreen/doctorprofilescreen.dart';
import 'package:incubatorapp/views/doctor/doctorscreen/editdoctorscreen.dart';
import 'package:incubatorapp/views/doctor/doctorscreen/newdoctorscreen.dart';
import 'package:incubatorapp/views/doctorshift/doctorshiftscreen/editdoctorshiftscreen.dart';
import 'package:incubatorapp/views/doctorshift/doctorshiftscreen/newdoctorshiftscreen.dart';
import 'package:incubatorapp/views/history/historyscreen/historyscreen.dart';
import 'package:incubatorapp/views/home/homepage.dart';
import 'package:incubatorapp/views/home/welcomescreen.dart';
import 'package:incubatorapp/views/incubator/incubatorscreen/editincubatorscreen.dart';
import 'package:incubatorapp/views/incubator/incubatorscreen/incubatorscreen.dart';
import 'package:incubatorapp/views/incubator/incubatorscreen/newincubatorscreen.dart';
import 'package:incubatorapp/views/laboratory/laboratoryscreen/searchlaboratoryscreen.dart';
import 'package:incubatorapp/views/login/loginscreen/forgetpasswordscreen.dart';
import 'package:incubatorapp/views/login/loginscreen/signinscreen.dart';
import 'package:incubatorapp/views/login/loginscreen/usertypescreen.dart';
import 'package:incubatorapp/views/medicine/medicinescreen/searchmedicinescreen.dart';
import 'package:incubatorapp/views/nurse/nursescreen/editnursescreen.dart';
import 'package:incubatorapp/views/nurse/nursescreen/newnursescreen.dart';
import 'package:incubatorapp/views/nurse/nursescreen/nurseprofilescreen.dart';
import 'package:incubatorapp/views/nurseshift/nurseshiftscreen/editnurseshiftscreen.dart';
import 'package:incubatorapp/views/nurseshift/nurseshiftscreen/newnurseshiftscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/editpatientscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/newpatientscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientdetailscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientlistscreen.dart';
import 'package:incubatorapp/views/patient/patientscreen/patientprofilescreen.dart';
import 'package:incubatorapp/views/patientconsumablenurse/patientconsumablenursescreen/newpatientconsumablenursescreen.dart';
import 'package:incubatorapp/views/patientconsumablenurse/patientconsumablenursescreen/patientconsumablenursescreen.dart';
import 'package:incubatorapp/views/patientlaboratory/patientlaboratoryscreen/editpatientlaboratoryscreen.dart';
import 'package:incubatorapp/views/patientlaboratory/patientlaboratoryscreen/newpatientlaboratoryscreen.dart';
import 'package:incubatorapp/views/patientlaboratory/patientlaboratoryscreen/patientlaboratoryscreen.dart';
import 'package:incubatorapp/views/patientmedicinedoctor/patientmedicinedoctorscreen/newpatientmedicinedoctorscreen.dart';
import 'package:incubatorapp/views/patientmedicinedoctor/patientmedicinedoctorscreen/patientmedicinedoctorscreen.dart';
import 'package:incubatorapp/views/patientxray/patientxrayscreen/newpatientxrayscreen.dart';
import 'package:incubatorapp/views/patientxray/patientxrayscreen/patientxrayscreen.dart';
import 'package:incubatorapp/views/report/reportscreen/reportscreen.dart';
import 'package:incubatorapp/views/status/statewebpage/newstatusscreen.dart';
import 'package:incubatorapp/views/xray/xrayscreen/searchxrayscreen.dart';

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

WebPageModel webPageModel = new WebPageModel();

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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
      home: WelcomeScreen(),
    );
  }
}

//MyHomePage(title: 'Generate Data',)

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
  UserData ud = new UserData();

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

  Widget basicDataButtons() {
    return Column(
      children: [
        buttonWidget('Add Incubator List', bd.addIncubatorData),
        buttonWidget('Add Condition List', bd.addConditionData),
        buttonWidget('Add Shift List', bd.addShiftData),
        buttonWidget('Add Laboratory List', bd.addLaboratoryData),
        buttonWidget('Add XRay List', bd.addXRayData),
        buttonWidget('Add Medicine List', bd.addMedicineData),
        buttonWidget('Add Consumable List', bd.addConsumableData),
        buttonWidget('Add Extra List', bd.addExtraData),
        buttonWidget('Add State Type List', bd.addStateTypeData),
      ],
    );
  }

  Widget userDataButton() {
    return Column(
      children: [
        buttonWidget('Add Doctor', ud.addUserDoctor),
        buttonWidget('Add Nurse', ud.addUserNurse),
        buttonWidget('Add Accountant', ud.addUserAccountant),
        buttonWidget('Add User of type Patient', ud.addUserPatient),
        buttonWidget('Add Patient Detail', ud.addPatientDetailData),
      ],
    );
  }

  Widget patientDataDetail(int v) {
    //1
    Widget statusWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Update Patient List', ud.updatePatientList),
        buttonWidget('Add Status', ud.addPatientStatus),
      ],
    );
    //2
    Widget laboratoryWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Add Laboratory', ud.addPatientLaboratory),
        Divider(),
        buttonWidget('Get Laboratory', ud.getPatientLaboratory),
        buttonWidget('Update Laboratory', ud.updatePatientLaboratory),
      ],
    );
    //3
    Widget xRayWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Add XRay', ud.addPatientXRay),
        Divider(),
        buttonWidget('get XRay', ud.getPatientXRay),
        buttonWidget('Update XRay', ud.updatePatientXRay),
      ],
    );
    //4
    Widget medicineWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Add Medicine', ud.addPatientMedicine),
        Divider(),
        buttonWidget('Get Medicine', ud.getPatientMedicineList),
        buttonWidget('Update Medicine', ud.updatePatientMedicine),
      ],
    );
    //5
    Widget consumableWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Add Consumable', ud.addPatientConsumable),
        Divider(),
        buttonWidget('Get Consumable', ud.getPatientConsumableList),
        buttonWidget('Update Consumable', ud.updatePatientConsumable),
      ],
    );
    //6
    Widget extraWidget = Column(
      children: [
        buttonWidget('Get Patient List', ud.getPatientList),
        buttonWidget('Add Extra', ud.addPatientExtra),
        Divider(),
        buttonWidget('Get Extra', ud.getPatientExtra),
        buttonWidget('Update Extra', ud.updatePatientExtra),
      ],
    );

    Widget currentWidget = Container();

    if (v == 1) {
      currentWidget = statusWidget;
    } else if (v == 2) {
      currentWidget = laboratoryWidget;
    } else if (v == 3) {
      currentWidget = xRayWidget;
    } else if (v == 4) {
      currentWidget = medicineWidget;
    } else if (v == 5) {
      currentWidget = consumableWidget;
    } else if (v == 6) {
      currentWidget = extraWidget;
    }

    return currentWidget;
  }

  @override
  Widget build(BuildContext context) {
/*    Container(
      child: Text(notification),
    ),

    floatingActionButton: new FloatingActionButton(
      //onPressed: _running ? _stop : _start,
      tooltip: _running ? 'Timer Stop' : 'Timer Start',
      child: _running ? Icon(Icons.stop) : Icon(Icons.play_arrow),
    )
    */

    DateTime d = DateTime.parse('2020-04-01');

    print(d.toString());

    //1.userDataButton()
    //2.basicDataButtons()
    //3.patientDataDetail()

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: patientDataDetail(6),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
