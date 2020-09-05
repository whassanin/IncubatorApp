import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientModel extends Model {
  Api _api = new Api('patient');

  List<Patient> patientList;

  Patient _currentPatient;

  Patient get currentPatient => _currentPatient;

  int _currentTab = 0;

  int get currentTab => _currentTab;

  void setCurrentTab(int v) {
    _currentTab = v;
    notifyListeners();
  }

  void createPatient() {
    _currentPatient = new Patient(
      0,
      '',
      '',
      false,
      DateTime.now(),
      '',
      0,
      '',
      false,
      DateTime.now(),
      1,
      1,
      0,
      null,
      null,
      null,
      null,
      null,
    );
  }

  void editPatient(Patient editPatient) {
    _currentPatient = editPatient;
  }

  void setUserId(int userId) {
    _currentPatient.userId = userId;
    notifyListeners();
  }

  int getUserId() {
    return _currentPatient.userId;
  }

  void setMotherName(String val) {
    _currentPatient.motherName = val;
    notifyListeners();
  }

  String getMotherName() {
    return _currentPatient.motherName;
  }

  void setFatherName(String val) {
    _currentPatient.fatherName = val;
    notifyListeners();
  }

  String getFatherName() {
    return _currentPatient.fatherName;
  }

  void setGender(bool val) {
    _currentPatient.gender = val;
    notifyListeners();
  }

  bool getGender() {
    return _currentPatient.gender;
  }

  void setIsOnLightRay(bool val) {
    _currentPatient.isOnLightRay = val;
    notifyListeners();
  }

  bool getIsOnLightRay() {
    return _currentPatient.isOnLightRay;
  }

  void setDateOfBirth(DateTime val) {
    _currentPatient.dateOfBirth = val;
    notifyListeners();
  }

  DateTime getDateOfBirth() {
    return _currentPatient.dateOfBirth;
  }

  void setAddress(String val) {
    _currentPatient.address = val;
    notifyListeners();
  }

  String getAddress() {
    return _currentPatient.address;
  }

  void setWeight(double val) {
    _currentPatient.weight = val;
    notifyListeners();
  }

  double getWeight() {
    return _currentPatient.weight;
  }

  void setStateTypeId(int val) {
    _currentPatient.stateTypeId = val;
    notifyListeners();
  }

  int getStateTypeId() {
    return _currentPatient.stateTypeId;
  }

  void setSSN(String val) {
    _currentPatient.ssn = val;
    notifyListeners();
  }

  String getSSN() {
    return _currentPatient.ssn;
  }

  void setCreatedDate(DateTime val) {
    _currentPatient.createdDate = val;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentPatient.createdDate;
  }

  void setConditionId(int val) {
    _currentPatient.conditionId = val;
    notifyListeners();
  }

  int getConditionId() {
    return _currentPatient.conditionId;
  }

  void setIncubatorId(int val) {
    _currentPatient.incubatorId = val;
    notifyListeners();
  }

  int getIncubatorId() {
    return _currentPatient.incubatorId;
  }

  void updateState(Status status) {
    currentPatient.statusList.insert(0, status);
    notifyListeners();
  }

  void search() {}

  void filterByState(String state) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('state');
    values.add(state);

    List<dynamic> patientListMap = await _api.filter(fields, values);
    patientList = patientListMap.map((e) => Patient.fromJson(e)).toList();

    await Future.delayed(Duration(seconds: 1));

    notifyListeners();
  }

  void _readForDoctorAndNurse(String id) async {
    _currentPatient.statusList =
        await statusModel.readByPatientId(int.parse(id));
    _currentPatient.patientAnalysisList =
        await patientAnalysisModel.readByPatientId(int.parse(id));
    _currentPatient.patientXRaysList =
        await patientXRayModel.readByPatientId(int.parse(id));
    _currentPatient.patientMedicineDoctorList =
        await patientMedicineDoctorModel.readByPatientId(int.parse(id));
    _currentPatient.patientConsumableNurseList =
        await patientConsumableNurseModel.readByPatientId(int.parse(id));
    _currentPatient.patientExtraList =
        await patientExtraModel.readByPatientId(int.parse(id));
  }

  void _readForAccountant(String id) async {
    _currentPatient.billList = await billModel.readByPatientId(int.parse(id));
    _currentPatient.patientAnalysisList = await patientAnalysisModel
        .readByPatientIdAndPendingAnalysis(int.parse(id));
    _currentPatient.patientXRaysList =
        await patientXRayModel.readByPatientIdAndPendingXRay(int.parse(id));
    _currentPatient.patientMedicineDoctorList = await patientMedicineDoctorModel
        .readByPatientIdAndPendingMedicine(int.parse(id));
    _currentPatient.patientConsumableNurseList =
        await patientConsumableNurseModel
            .readByPatientIdAndPendingConsumable(int.parse(id));
    _currentPatient.patientExtraList =
        await patientExtraModel.readByPatientIdAndPendingExtra(int.parse(id));

    patientExtraModel.readByPatientId(patientModel.currentPatient.userId);
  }

  void _readForPatient(String id) async {
    _currentPatient.billList = await billModel.readByPatientId(int.parse(id));
    _currentPatient.statusList =
        await statusModel.readByPatientId(int.parse(id));
    _currentPatient.patientAnalysisList =
        await patientAnalysisModel.readByPatientId(int.parse(id));
    _currentPatient.patientXRaysList =
        await patientXRayModel.readByPatientId(int.parse(id));
    _currentPatient.patientMedicineDoctorList =
        await patientMedicineDoctorModel.readByPatientId(int.parse(id));
    _currentPatient.patientConsumableNurseList =
        await patientConsumableNurseModel.readByPatientId(int.parse(id));
    _currentPatient.patientExtraList =
        await patientExtraModel.readByPatientId(int.parse(id));
    _currentPatient.creditCardList =
        await creditCardModel.readByPatientId(int.parse(id));
  }

  void readById(String id) async {
    Map<String, dynamic> patientMap = await _api.getById(id);

    _currentPatient = Patient.fromJson(patientMap);

    if (userPermission.isDoctor || userPermission.isNurse) {
      _readForDoctorAndNurse(id);
    } else if (userPermission.isAccountant) {
      _readForAccountant(id);
    } else if (userPermission.isPatient) {
      _readForPatient(id);
    }

    //notifyListeners();
  }

  Future<bool> create() async {
    print(_currentPatient.toJson().toString());
    int code = await _api.post(_currentPatient.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentPatient.toJson(), _currentPatient.userId.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatient.userId.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }
}
