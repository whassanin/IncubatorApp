import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientConsumableNurseModel extends Model {
  Api _api = new Api('patientconsumablenurse');

  List<PatientConsumableNurse> patientConsumableNurseList;

  PatientConsumableNurse _currentPatientConsumableNurse;

  PatientConsumableNurse get currentPatientConsumableNurse =>
      _currentPatientConsumableNurse;

  void createPatientConsumableNurse() {
    _currentPatientConsumableNurse =
        new PatientConsumableNurse(0, 0, 0, 0, 0, DateTime.now());
  }

  void editPatientConsumableNurse(
      PatientConsumableNurse editPatientConsumableNurse) {
    _currentPatientConsumableNurse = editPatientConsumableNurse;
  }

  void clearList(){
    if(patientConsumableNurseList!=null){
      if(patientConsumableNurseList.length > 0){
        patientConsumableNurseList.clear();
        notifyListeners();
      }
    }
  }

  void setPatientId(int patientId) {
    _currentPatientConsumableNurse.patientId = patientId;
  }

  int getPatientId() {
    return _currentPatientConsumableNurse.patientId;
  }

  void setNurseId(int nurseId) {
    _currentPatientConsumableNurse.nurseId = nurseId;
  }

  int getNurseId() {
    return _currentPatientConsumableNurse.nurseId;
  }

  void setConsumableId(int consumableId) {
    _currentPatientConsumableNurse.consumableId = consumableId;
  }

  int getConsumableId() {
    return _currentPatientConsumableNurse.consumableId;
  }

  void setQuantity(int quantity) {
    _currentPatientConsumableNurse.quantity = quantity;
  }

  int getQuantity() {
    return _currentPatientConsumableNurse.quantity;
  }

  DateTime getCreatedDate() {
    return _currentPatientConsumableNurse.createdDate;
  }

  void readByPatientId() async {
    List<dynamic> patientAnalysisMap = await _api.filterByForeignKey(
        _currentPatientConsumableNurse.patientId.toString());
    patientConsumableNurseList = patientAnalysisMap
        .map((e) => PatientConsumableNurse.fromJson(e))
        .toList();

    notifyListeners();
  }

  void readByConsumableId() {}

  void readByNurseId() {}

  Future<bool> create() async {

    int code = await _api.postSubValue(_currentPatientConsumableNurse.toJson(),
        _currentPatientConsumableNurse.patientId.toString());
    if (code == 201) {
      setPatientId(_currentPatientConsumableNurse.patientId);
      readByPatientId();

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.putSubValue(_currentPatientConsumableNurse.toJson(),
        _currentPatientConsumableNurse.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.deleteSubValue(_currentPatientConsumableNurse.id.toString());

    if (code == 204) {
      patientConsumableNurseList.remove(_currentPatientConsumableNurse);
      notifyListeners();

      return true;
    }
    return false;
  }
}
