import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientAnalysisModel extends Model {
  Api _api = new Api('patientanalysis');

  List<PatientAnalysis> patientAnalysisList;

  PatientAnalysis _currentPatientAnalysis;

  PatientAnalysis get patientAnalysis => _currentPatientAnalysis;

  void createPatientAnalysis() {
    _currentPatientAnalysis = new PatientAnalysis(0, 0, 0, ' ','Pending', DateTime.now());
  }

  void editPatientAnalysis(PatientAnalysis editPatientAnalysis) {
    _currentPatientAnalysis = editPatientAnalysis;
  }

  void setList(List<PatientAnalysis> list){
    patientAnalysisList = list;
  }

  void clearList() {
    if (patientAnalysisList != null) {
      if (patientAnalysisList.length > 0) {
        patientAnalysisList.clear();
        notifyListeners();
      }
    }
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

  void setBillStatus(String val) {
    _currentPatientAnalysis.billStatus = val;
    notifyListeners();
  }

  String getBillStatus() {
    return _currentPatientAnalysis.billStatus;
  }

  DateTime getCreatedDate() {
    return _currentPatientAnalysis.createdDate;
  }

  Future<List<PatientAnalysis>> readByPatientId(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientAnalysisMap = await _api.filter(fields, values);

    patientAnalysisList =
        patientAnalysisMap.map((e) => PatientAnalysis.fromJson(e)).toList();

    notifyListeners();

    return patientAnalysisList;
  }

  Future<List<PatientAnalysis>> readByPatientIdAndPendingAnalysis(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());
    fields.add('billStatus');
    values.add('Pending');

    List<dynamic> patientAnalysisMap = await _api.filter(fields, values);
    patientAnalysisList =
        patientAnalysisMap.map((e) => PatientAnalysis.fromJson(e)).toList();

    notifyListeners();

    return patientAnalysisList;
  }

  void readByAnalysisId(int analysisId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('analysisId');
    values.add(analysisId.toString());

    List<dynamic> patientAnalysisMap = await _api.filter(fields, values);
    patientAnalysisList =
        patientAnalysisMap.map((e) => PatientAnalysis.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentPatientAnalysis.toJson());
    if (code == 201) {
      patientAnalysisList.add(_currentPatientAnalysis);
      notifyListeners();
      readByPatientId(patientModel.currentPatient.userId);
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientAnalysis.toJson(), _currentPatientAnalysis.id.toString());

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
