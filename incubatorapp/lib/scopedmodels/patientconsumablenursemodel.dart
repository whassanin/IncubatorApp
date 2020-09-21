import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientConsumableNurseModel extends Model {
  Api _api = new Api('patientconsumablenurse');

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<PatientConsumableNurse> patientConsumableNurseList = [];

  PatientConsumableNurse _currentPatientConsumableNurse;

  PatientConsumableNurse get currentPatientConsumableNurse =>
      _currentPatientConsumableNurse;

  void createPatientConsumableNurse() {
    _currentPatientConsumableNurse =
        new PatientConsumableNurse(0, 0, 0, 0, 0, 'Pending', DateTime.now());
  }

  void editPatientConsumableNurse(
      PatientConsumableNurse editPatientConsumableNurse) {
    _currentPatientConsumableNurse = editPatientConsumableNurse;
  }

  void setList(List<PatientConsumableNurse> list) {
    patientConsumableNurseList = list;
    _isLoading = false;
    notifyListeners();
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
    notifyListeners();
  }

  int getConsumableId() {
    return _currentPatientConsumableNurse.consumableId;
  }

  void setQuantity(int quantity) {
    _currentPatientConsumableNurse.quantity = quantity;
    notifyListeners();
  }

  int getQuantity() {
    return _currentPatientConsumableNurse.quantity;
  }

  void setBillStatus(String val) {
    _currentPatientConsumableNurse.billStatus = val;
    notifyListeners();
  }

  String getBillStatus() {
    return _currentPatientConsumableNurse.billStatus;
  }

  DateTime getCreatedDate() {
    return _currentPatientConsumableNurse.createdDate;
  }

  void readAll() async {
    List<dynamic> patientConsumableNurseMap = await _api.get();
    patientConsumableNurseList = patientConsumableNurseMap
        .map((e) => PatientConsumableNurse.fromJson(e))
        .toList();
    notifyListeners();
  }

  void setIsLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  void clearList() {
    _isLoading = true;
    if (patientConsumableNurseList != null) {
      if (patientConsumableNurseList.length > 0) {
        patientConsumableNurseList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<PatientConsumableNurse>> readByPatientId(int patientId) async {
    clearList();

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientConsumableNurseMap = await _api.filter(fields, values);
    patientConsumableNurseList = patientConsumableNurseMap
        .map((e) => PatientConsumableNurse.fromJson(e))
        .toList();

    _isLoading = false;

    notifyListeners();

    return patientConsumableNurseList;
  }

  Future<List<PatientConsumableNurse>> readByPatientIdAndPendingConsumable(
      int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());
    fields.add('billStatus');
    values.add('Pending');

    List<dynamic> patientConsumableNurseMap = await _api.filter(fields, values);
    patientConsumableNurseList = patientConsumableNurseMap
        .map((e) => PatientConsumableNurse.fromJson(e))
        .toList();

    notifyListeners();

    return patientConsumableNurseList;
  }

  void readByConsumableId() {}

  void readByNurseId() {}

  Future<bool> create() async {
    int code = await _api.post(_currentPatientConsumableNurse.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientConsumableNurse.toJson(),
        _currentPatientConsumableNurse.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatientConsumableNurse.id.toString());

    if (code == 204) {
      patientConsumableNurseList.remove(_currentPatientConsumableNurse);
      notifyListeners();

      return true;
    }
    return false;
  }
}
