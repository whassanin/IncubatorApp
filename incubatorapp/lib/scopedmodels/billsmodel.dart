import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/analysis.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:scoped_model/scoped_model.dart';

class BillModel extends Model {
  Api _api = new Api('bill');

  List<Bill> billList;

  Bill _currentBill;

  Bill get currentBill => _currentBill;

  void createBill() {
    _currentBill = new Bill(0, DateTime.now(), 0, 0, 0, 0, 0, 0, 0, 0, 0, null);
  }

  Bill newBill(DateTime currentDateTime){
    Bill newBill = new Bill(0, currentDateTime, 0, 0, 0, 0, 0, 0, 0, 0, 0, null);
    return newBill;
  }

  void editBill(Bill editBill) {
    _currentBill = editBill;
  }

  DateTime getCreatedDate() {
    return _currentBill.createdDate;
  }

  void setPaid(double paid) {
    _currentBill.paid = paid;
  }

  double getPaid() {
    return _currentBill.paid;
  }

  void setDayCost(double dayCost) {
    _currentBill.dayCost = dayCost;
  }

  double getDayCost() {
    return _currentBill.dayCost;
  }

  void setIncubatorClean(double incubatorClean) {
    _currentBill.incubatorClean = incubatorClean;
  }

  double getIncubatorClean() {
    return _currentBill.incubatorClean;
  }

  void setConsumable(double consumable) {
    _currentBill.consumable = consumable;
  }

  double getConsumable() {
    return _currentBill.consumable;
  }

  void setAnalysis(double analysis) {
    _currentBill.analysis = analysis;
  }

  double getAnalysis() {
    return _currentBill.analysis;
  }

  void setXRay(double xRay) {
    _currentBill.xRay = xRay;
  }

  double getXRay() {
    return _currentBill.xRay;
  }

  void setLightRays(double lightRays) {
    _currentBill.lightRays = lightRays;
  }

  double getLightRays() {
    return _currentBill.lightRays;
  }

  void setMedicine(double medicine) {
    _currentBill.medicine = medicine;
  }

  double getMedicine() {
    return _currentBill.medicine;
  }

  void setPatientId(int patientId) {
    _currentBill.patientId = patientId;
  }

  int gePatientId() {
    return _currentBill.patientId;
  }

  String formatDate(DateTime dateTime){
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();

    return v;
  }

  void _calculateAnalysis(Patient cp){
    List<PatientAnalysis> cpal = cp.patientAnalysisList
        .where((element) => element.billStatus == 'Pending').toList();

    cpal.forEach((cpa) {
      int index = billList.indexWhere((cb) => formatDate(cb.createdDate) == formatDate(cpa.createdDate));

      Bill bill;

      if(index < 0){
        bill = newBill(cpa.createdDate);
      }else {
        bill = billList[index];
      }

      Analysis analysis;

      List<Analysis> cal = analysisModel.analysisList.where((element) => element.id == cpa.analysisId).toList();

      if(cal.length > 0){
        analysis = cal[0];
      }

      if(analysis!=null){
        bill.analysis += analysis.price;
      }

      if(index < 0){
        billList.add(bill);
      }
      else {
        billList[index] = bill;
      }

      cp.billList = billList;

      notifyListeners();
    });
  }

  void _calculateXRay(Patient cp){
    List<PatientXRay> cpxl = cp.patientXRaysList
        .where((element) => element.billStatus == 'Pending').toList();

    cpxl.forEach((cpx) {
      int index = billList.indexWhere((cb) => formatDate(cb.createdDate) == formatDate(cpx.createdDate));

      Bill bill;

      if(index < 0){
        bill = newBill(cpx.createdDate);
      }else {
        bill = billList[index];
      }

      XRay xRay;

      List<XRay> cxl = xRayModel.xRayList.where((element) => element.id == cpx.xRayId).toList();

      if(cxl.length > 0){
        xRay = cxl[0];
      }

      if(xRay!=null){
        bill.xRay += xRay.price;
      }

      if(index < 0){
        billList.add(bill);
      }
      else {
        billList[index] = bill;
      }

      cp.billList = billList;

      notifyListeners();
    });
  }

  void _calculateMedicine(Patient cp){
    List<PatientMedicineDoctor> cpmdl = cp.patientMedicineDoctorList
        .where((element) => element.billStatus == 'Pending').toList();

    cpmdl.forEach((cpmd) {
      int index = billList.indexWhere((cb) => formatDate(cb.createdDate) == formatDate(cpmd.createdDate));

      Bill bill;

      if(index < 0){
        bill = newBill(cpmd.createdDate);
      }else {
        bill = billList[index];
      }

      Medicine medicine;

      List<Medicine> cml = medicineModel.medicineList.where((element) => element.id == cpmd.medicineId).toList();

      if(cml.length > 0){
        medicine = cml[0];
      }

      if(medicine!=null){
        bill.medicine += (medicine.price * cpmd.quantity);
      }

      if(index < 0){
        billList.add(bill);
      }
      else {
        billList[index] = bill;
      }

      cp.billList = billList;

      notifyListeners();
    });
  }

  void _calculateConsumable(Patient cp){
    List<PatientConsumableNurse> cpcnl = cp.patientConsumableNurseList
        .where((element) => element.billStatus == 'Pending').toList();

    cpcnl.forEach((cpcn) {
      int index = billList.indexWhere((cb) => formatDate(cb.createdDate) == formatDate(cpcn.createdDate));

      Bill bill;

      if(index < 0){
        bill = newBill(cpcn.createdDate);
      }else {
        bill = billList[index];
      }

      Consumable consumable;

      List<Consumable> ccl = consumableModel.consumableList.where((element) => element.id == cpcn.consumableId).toList();

      if(ccl.length > 0){
        consumable = ccl[0];
      }

      if(consumable!=null){
        bill.consumable += (consumable.price * cpcn.quantity);
      }

      if(index < 0){
        billList.add(bill);
      }
      else {
        billList[index] = bill;
      }

      cp.billList = billList;

      notifyListeners();
    });
  }

  void calculateBills() {

    Patient cp = patientModel.currentPatient;

    _calculateAnalysis(cp);

    _calculateXRay(cp);

    _calculateMedicine(cp);

    _calculateConsumable(cp);

  }

  Future<List<Bill>> readByPatientId(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> billListMap;

    billListMap = await _api.filter(fields, values);

    if (billListMap != null) {
      billList = billListMap.map((e) => Bill.fromJson(e)).toList();
    }

    notifyListeners();

    return billList;
  }

  Future<bool> create() async {
    int code = await _api.post(_currentBill.toJson());
    if (code == 201) {
      billList.add(_currentBill);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
        await _api.put(_currentBill.toJson(), _currentBill.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentBill.id.toString());

    if (code == 204) {
      billList.remove(_currentBill);
      notifyListeners();

      return true;
    }
    return false;
  }
}
