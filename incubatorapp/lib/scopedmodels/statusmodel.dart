import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:scoped_model/scoped_model.dart';

class StatusModel extends Model {
  Api _api = new Api('status');

  List<Status> statusList;

  Status _currentStatus;

  Status get currentStatus => _currentStatus;

  void createStatus() {
    _currentStatus =
        new Status(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, DateTime.now(), 0, 0);
  }

  void editStatus(Status editStatus) {
    _currentStatus = editStatus;
  }

  void setHeartRate(double heartRate) {
    _currentStatus.heartRate = heartRate;
    notifyListeners();
  }

  double getHeartRate() {
    return _currentStatus.heartRate;
  }

  void setPulseRate(double pulseRate) {
    _currentStatus.pulseRate = pulseRate;
    notifyListeners();
  }

  double getPulseRate() {
    return _currentStatus.pulseRate;
  }

  void setOxygen(double oxygen) {
    _currentStatus.oxygen = oxygen;
    notifyListeners();
  }

  double getOxygen() {
    return _currentStatus.oxygen;
  }

  void setWeight(double weight) {
    _currentStatus.weight = weight;
    notifyListeners();
  }

  double getWeight() {
    return _currentStatus.weight;
  }

  void setSugar(double sugar) {
    _currentStatus.sugar = sugar;
    notifyListeners();
  }

  double getSugar() {
    return _currentStatus.sugar;
  }

  void setUrine(double urine) {
    _currentStatus.urine = urine;
    notifyListeners();
  }

  double getUrine() {
    return _currentStatus.urine;
  }

  void setStool(double stool) {
    _currentStatus.stool = stool;
    notifyListeners();
  }

  double getStool() {
    return _currentStatus.stool;
  }

  void setBloodPressure(double bloodPressure) {
    _currentStatus.bloodPressure = bloodPressure;
    notifyListeners();
  }

  double getBloodPressure() {
    return _currentStatus.bloodPressure;
  }

  void setTemperature(double temperature) {
    _currentStatus.temperature = temperature;
    notifyListeners();
  }

  double getTemperature() {
    return _currentStatus.temperature;
  }

  void setIncubatorTemperature(double incubatorTemperature) {
    _currentStatus.incubatorTemperature = incubatorTemperature;
    notifyListeners();
  }

  double getIncubatorTemperature() {
    return _currentStatus.incubatorTemperature;
  }

  void setPatientId(int patientId) {
    _currentStatus.patientId = patientId;
  }

  int getPatientId() {
    return _currentStatus.patientId;
  }

  void setNurseId(int nurseId) {
    _currentStatus.nurseId = nurseId;
  }

  int getNurseId() {
    return _currentStatus.nurseId;
  }

  DateTime getDateTime() {
    return _currentStatus.createdDate;
  }

  void clearList() {
    if (statusList != null) {
      if (statusList.length > 0) {
        statusList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<Status>> readByPatientId(int patientId, {int limit}) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> statusListMap;

    if (limit != null) {
      if(limit > 0){
        fields.add('limit');
        values.add(limit.toString());
        Map<String, dynamic> statusMap = await _api.filterWithLimit(
          fields,
          values,
        );
        statusMap.forEach((e, f) {
          if (e == 'results') {
            statusListMap = f;
          }
        });
      }else {
        statusListMap = await _api.filter(fields, values);
      }
    } else {
      statusListMap = await _api.filter(fields, values);
    }

    if(statusListMap!=null){
      statusList = statusListMap.map((e) => Status.fromJson(e)).toList();
    }

    notifyListeners();

    return statusList;
  }

  Future<bool> create() async {
    int code = await _api.post(_currentStatus.toJson());
    if (code == 201) {
      readByPatientId(_currentStatus.patientId);
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
        await _api.put(_currentStatus.toJson(), _currentStatus.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentStatus.id.toString());

    if (code == 204) {
      statusList.remove(_currentStatus);
      notifyListeners();

      return true;
    }
    return false;
  }
}
