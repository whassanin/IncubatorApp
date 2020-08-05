import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:scoped_model/scoped_model.dart';

class StatusModel extends Model{

  Api _api =new Api('status');

  List<Status> statusList;

  Status _currentStatus;

  void createStatus(){
    _currentStatus = new Status(0, 0,0,0,0,0,0,0,0,0,0,DateTime.now(),0,0);
  }

  void editStatus(Status editStatus){
    _currentStatus = editStatus;
  }

  void setHeartRate(double heartRate){
    _currentStatus.heartRate = heartRate;
  }

  double getHeartRate(){
    return _currentStatus.heartRate;
  }

  void setPulseRate(double pulseRate){
    _currentStatus.pulseRate = pulseRate;
  }

  double getPulseRate(){
    return _currentStatus.pulseRate;
  }

  void setOxygen(double oxygen){
    _currentStatus.oxygen = oxygen;
  }

  double getOxygen(){
    return _currentStatus.oxygen;
  }

  void setWeight(double weight){
    _currentStatus.weight = weight;
  }

  double getWeight(){
    return _currentStatus.weight;
  }

  void setSugar(double sugar){
    _currentStatus.sugar = sugar;
  }

  double getSugar(){
    return _currentStatus.sugar;
  }

  void setUrine(double urine){
    _currentStatus.urine = urine;
  }

  double getUrine(){
    return _currentStatus.urine;
  }

  void setStool(double stool){
    _currentStatus.urine = stool;
  }

  double getStool(){
    return _currentStatus.stool;
  }

  void setBloodPressure(double bloodPressure){
    _currentStatus.bloodPressure = bloodPressure;
  }

  double getBloodPressure(){
    return _currentStatus.bloodPressure;
  }

  void setTemperature(double temperature){
    _currentStatus.temperature = temperature;
  }

  double getTemperature(){
    return _currentStatus.temperature;
  }

  void setIncubatorTemperature(double incubatorTemperature){
    _currentStatus.incubatorTemperature = incubatorTemperature;
  }

  double getIncubatorTemperature(){
    return _currentStatus.incubatorTemperature;
  }

  void setPatientId(int patientId){
    _currentStatus.patientId = patientId;
  }

  int getPatientId(){
    return _currentStatus.patientId;
  }

  void setNurseId(int nurseId){
    _currentStatus.nurseId = nurseId;
  }

  int getNurseId(){
    return _currentStatus.nurseId;
  }

  DateTime getDateTime(){
    return _currentStatus.createdDate;
  }

  void readByPatientId() async{
    List<dynamic> billsMap = await _api.filter(_currentStatus.patientId.toString());
    statusList = billsMap.map((e) => Status.fromJson(e)).toList();
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

  Future<bool> create() async{
    int code = await _api.post(_currentStatus.toJson());
    if (code == 201) {
      statusList.add(_currentStatus);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async{
    int code = await _api.put(
        _currentStatus.toJson(), _currentStatus.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async{
    int code = await _api.delete(_currentStatus.id.toString());

    if (code == 204) {
      statusList.remove(_currentStatus);
      notifyListeners();

      return true;
    }
    return false;
  }

}