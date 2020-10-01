import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientextra.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientExtraModel extends Model {
  Api _api = new Api('patientextra');

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<PatientExtra> patientExtraList = [];

  PatientExtra _currentPatientExtra;

  PatientExtra get patientExtra => _currentPatientExtra;

  void createPatientExtra() {
    _currentPatientExtra = new PatientExtra(0, 0,0,'Pending', DateTime.now());
  }

  void editPatientExtra(PatientExtra editPatientExtra) {
    _currentPatientExtra = editPatientExtra;
  }

  void setList(List<PatientExtra> list){
    clearList();
    patientExtraList = list;
    _isLoading = false;
    notifyListeners();
  }

  void setPatientId(int patientId) {
    _currentPatientExtra.patientId = patientId;
  }

  int getPatientId() {
    return _currentPatientExtra.patientId;
  }

  void setExtraId(int extraId) {
    _currentPatientExtra.extraId = extraId;
    notifyListeners();
  }

  int getExtraId() {
    return _currentPatientExtra.extraId;
  }

  void setBillStatus(String val) {
    _currentPatientExtra.billStatus = val;
    notifyListeners();
  }

  String getBillStatus() {
    return _currentPatientExtra.billStatus;
  }

  DateTime getCreatedDate() {
    return _currentPatientExtra.createdDate;
  }

  void readAll() async {
    List<dynamic> patientExtraMap = await _api.get();
    patientExtraList =
        patientExtraMap.map((e) => PatientExtra.fromJson(e)).toList();
    notifyListeners();
  }

  void setIsLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  void clearList() {
    _isLoading = true;
    if (patientExtraList != null) {
      if (patientExtraList.length > 0) {
        patientExtraList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<PatientExtra>> readByPatientId(int patientId) async {
    clearList();

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientExtraMap = await _api.filter(fields, values);
    patientExtraList =
        patientExtraMap.map((e) => PatientExtra.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();

    return patientExtraList;
  }

  Future<List<PatientExtra>> readByPatientIdAndPendingExtra(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());
    fields.add('billStatus');
    values.add('Pending');

    List<dynamic> patientExtraMap = await _api.filter(fields, values);
    patientExtraList =
        patientExtraMap.map((e) => PatientExtra.fromJson(e)).toList();

    notifyListeners();

    return patientExtraList;
  }

  void readByExtraId(int extraId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('extraId');
    values.add(extraId.toString());

    List<dynamic> patientExtraMap = await _api.filter(fields, values);
    patientExtraList =
        patientExtraMap.map((e) => PatientExtra.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentPatientExtra.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientExtra.toJson(), _currentPatientExtra.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatientExtra.id.toString());

    if (code == 204) {
      patientExtraList.remove(_currentPatientExtra);
      notifyListeners();

      return true;
    }
    return false;
  }
}
