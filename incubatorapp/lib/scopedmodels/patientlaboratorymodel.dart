import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientLaboratoryModel extends Model {
  Api _api = new Api('patientlaboratory');

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<PatientLaboratory> patientLaboratoryList;

  PatientLaboratory _currentPatientLaboratory;

  PatientLaboratory get patientLaboratory => _currentPatientLaboratory;

  void createPatientLaboratory() {
    _currentPatientLaboratory =
        new PatientLaboratory(0, 0, 0, ' ', 'Pending', DateTime.now());
  }

  void editPatientLaboratory(PatientLaboratory editPatientLaboratory) {
    _currentPatientLaboratory = editPatientLaboratory;
  }

  void setList(List<PatientLaboratory> list) {
    patientLaboratoryList = list;
  }

  void setPatientId(int patientId) {
    _currentPatientLaboratory.patientId = patientId;
  }

  int getPatientId() {
    return _currentPatientLaboratory.patientId;
  }

  void setLaboratoryId(int laboratoryId) {
    _currentPatientLaboratory.laboratoryId = laboratoryId;
    notifyListeners();
  }

  int getLaboratoryId() {
    return _currentPatientLaboratory.laboratoryId;
  }

  void setResult(String result) {
    _currentPatientLaboratory.result = result;
  }

  String getResult() {
    return _currentPatientLaboratory.result;
  }

  void setBillStatus(String val) {
    _currentPatientLaboratory.billStatus = val;
    notifyListeners();
  }

  String getBillStatus() {
    return _currentPatientLaboratory.billStatus;
  }

  DateTime getCreatedDate() {
    return _currentPatientLaboratory.createdDate;
  }

  void readAll() async {
    List<dynamic> patientLaboratoryMap = await _api.get();
    patientLaboratoryList =
        patientLaboratoryMap.map((e) => PatientLaboratory.fromJson(e)).toList();
    notifyListeners();
  }

  void setIsLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  void clearList() {
    _isLoading = true;
    if (patientLaboratoryList != null) {
      if (patientLaboratoryList.length > 0) {
        patientLaboratoryList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<PatientLaboratory>> readByPatientId(int patientId) async {
    clearList();

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientLaboratoryMap = await _api.filter(fields, values);

    patientLaboratoryList =
        patientLaboratoryMap.map((e) => PatientLaboratory.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();

    return patientLaboratoryList;
  }

  Future<List<PatientLaboratory>> readByPatientIdAndPendingLaboratory(
      int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());
    fields.add('billStatus');
    values.add('Pending');

    List<dynamic> patientLaboratoryMap = await _api.filter(fields, values);
    patientLaboratoryList =
        patientLaboratoryMap.map((e) => PatientLaboratory.fromJson(e)).toList();

    notifyListeners();

    return patientLaboratoryList;
  }

  void readByLaboratoryId(int laboratoryId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('laboratoryId');
    values.add(laboratoryId.toString());

    List<dynamic> patientLaboratoryMap = await _api.filter(fields, values);
    patientLaboratoryList =
        patientLaboratoryMap.map((e) => PatientLaboratory.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentPatientLaboratory.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientLaboratory.toJson(),
        _currentPatientLaboratory.id.toString());
    if (code == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatientLaboratory.id.toString());

    if (code == 204) {
      patientLaboratoryList.remove(_currentPatientLaboratory);
      notifyListeners();

      return true;
    }
    return false;
  }
}
