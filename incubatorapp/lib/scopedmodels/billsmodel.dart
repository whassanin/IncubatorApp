import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:scoped_model/scoped_model.dart';

class BillModel extends Model{

  Api _api = new Api('bill');

  List<Bill> billList;

  Bill _currentBill;

  Bill get currentBill => _currentBill;
  
  void createBill(){
    _currentBill = new Bill(0, DateTime.now(), 0, 0, 0, 0, 0, 0, 0, 0, 0, null);
  }

  void editBill(Bill editBill){
    _currentBill = editBill;
  }

  DateTime getCreatedDate(){
    return _currentBill.createdDate;
  }

  void setPaid(double paid){
    _currentBill.paid = paid;
  }

  double getPaid(){
    return _currentBill.paid;
  }

  void setDayCost(double dayCost){
    _currentBill.dayCost = dayCost;
  }

  double getDayCost(){
    return _currentBill.dayCost;
  }

  void setIncubatorClean(double incubatorClean){
    _currentBill.incubatorClean = incubatorClean;
  }

  double getIncubatorClean(){
    return _currentBill.incubatorClean;
  }

  void setConsumable(double consumable){
    _currentBill.consumable = consumable;
  }

  double getConsumable(){
    return _currentBill.consumable;
  }

  void setAnalysis(double analysis){
    _currentBill.analysis = analysis;
  }

  double getAnalysis(){
    return _currentBill.analysis;
  }

  void setXRay(double xRay){
    _currentBill.xRay = xRay;
  }

  double getXRay(){
    return _currentBill.xRay;
  }

  void setLightRays(double lightRays){
    _currentBill.lightRays = lightRays;
  }

  double getLightRays(){
    return _currentBill.lightRays;
  }

  void setMedicine(double medicine){
    _currentBill.medicine = medicine;
  }

  double getMedicine(){
    return _currentBill.medicine;
  }

  void setPatientId(int patientId){
    _currentBill.patientId = patientId;
  }

  int gePatientId(){
    return _currentBill.patientId;
  }
  
  void readByPatientId() async{
    List<dynamic> billsMap = await _api.filterByForeignKey(_currentBill.patientId.toString());
    billList = billsMap.map((e) => Bill.fromJson(e)).toList();
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

  Future<bool> create() async{
    int code = await _api.post(_currentBill.toJson());
    if (code == 201) {
      billList.add(_currentBill);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async{
    int code = await _api.put(
        _currentBill.toJson(), _currentBill.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async{
    int code = await _api.delete(_currentBill.id.toString());

    if (code == 204) {
      billList.remove(_currentBill);
      notifyListeners();

      return true;
    }
    return false;
  }

}