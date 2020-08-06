import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientAnalysisModel extends Model {
  Api _api = new Api('patientanalysis');

  Api _apiReverse = new Api('analysispatient');

  List<PatientAnalysis> patientAnalysisList;

  PatientAnalysis _currentPatientAnalysis;

  PatientAnalysis get patientAnalysis => _currentPatientAnalysis;

  void createPatientAnalysis() {
    _currentPatientAnalysis = new PatientAnalysis(0, 0, 0, ' ', DateTime.now());
  }

  void editPatientAnalysis(PatientAnalysis editPatientAnalysis) {
    _currentPatientAnalysis = editPatientAnalysis;
  }

  void setPatientId(int patientId) {
    _currentPatientAnalysis.patientId = patientId;
  }

  int getPatientId() {
    return _currentPatientAnalysis.patientId;
  }

  void setAnalysisId(int analysisId) {
    _currentPatientAnalysis.analysisId = analysisId;
    notifyListeners();
  }

  int getAnalysisId() {
    return _currentPatientAnalysis.analysisId;
  }

  void setResult(String result) {
    _currentPatientAnalysis.result = result;
  }

  String getResult() {
    return _currentPatientAnalysis.result;
  }

  DateTime getCreatedDate() {
    return _currentPatientAnalysis.createdDate;
  }

  void readByPatientId() async {
    List<dynamic> patientAnalysisMap = await _api
        .filterByForeignKey(_currentPatientAnalysis.patientId.toString());
    patientAnalysisList =
        patientAnalysisMap.map((e) => PatientAnalysis.fromJson(e)).toList();
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }

  void readByAnalysisId() async {
    List<dynamic> patientAnalysisMap = await _apiReverse
        .filterByForeignKey(_currentPatientAnalysis.analysisId.toString());
    patientAnalysisList =
        patientAnalysisMap.map((e) => PatientAnalysis.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    print(_currentPatientAnalysis.toJson().toString());
    int code = await _api.postSubValue(_currentPatientAnalysis.toJson(),
        _currentPatientAnalysis.patientId.toString());
    if (code == 201) {
      patientAnalysisList.add(_currentPatientAnalysis);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientAnalysis.toJson(),
        _currentPatientAnalysis.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatientAnalysis.id.toString());

    if (code == 204) {
      patientAnalysisList.remove(_currentPatientAnalysis);
      notifyListeners();

      return true;
    }
    return false;
  }
}
