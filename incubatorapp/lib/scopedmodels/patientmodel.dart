import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/patientphone.dart';
import 'package:incubatorapp/scopedmodels/patientphonemodel.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientModel extends Model {
  Api _api = new Api('patient');

  PatientPhoneModel patientPhoneModel = new PatientPhoneModel();

  List<Patient> patientList;

  Patient _currentPatient;

  Patient get currentPatient => _currentPatient;

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
      '',
      '',
      DateTime.now(),
      0,
      0,
      null,
    );
  }

  void editPatient(Patient editPatient) {
    _currentPatient = editPatient;
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
    print('weight val:' + val.toString());
    _currentPatient.weight = val;
    print(_currentPatient.weight.toString());
    notifyListeners();
  }

  double getWeight() {
    return _currentPatient.weight;
  }

  void setSSN(String val) {
    _currentPatient.ssn = val;
    notifyListeners();
  }

  String getSSN() {
    return _currentPatient.ssn;
  }

  void setIsOut(bool val) {
    _currentPatient.isOut = val;
    notifyListeners();
  }

  bool getIsOut() {
    return _currentPatient.isOut;
  }

  void setUserName(String val) {
    _currentPatient.username = val;
    notifyListeners();
  }

  String getUserName() {
    return _currentPatient.username;
  }

  void setPassword(String val) {
    _currentPatient.password = val;
    notifyListeners();
  }

  String getPassword() {
    return _currentPatient.password;
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

  void setPhone(String phone) async {
    if (_currentPatient.patientPhone == null) {
      patientPhoneModel.createPatientPhone();
      patientPhoneModel.setPhone(phone);
      patientPhoneModel.setPatientId(_currentPatient.id);
      _currentPatient.patientPhone = <PatientPhone>[];
      _currentPatient.patientPhone.add(patientPhoneModel.patientPhone);

    } else {
      patientPhoneModel.editPatientPhone(_currentPatient.patientPhone[0]);
      patientPhoneModel.setPhone(phone);
      _currentPatient.patientPhone[0] = patientPhoneModel.patientPhone;
    }
  }

  String getPhone() {
    String v;
    if (_currentPatient.patientPhone != null) {
      v = _currentPatient.patientPhone[0].phone;
    }
    return v;
  }

  void search() {}

  void filterByStatus() {}

  void readById(String id) async {
    Map<String, dynamic> patientMap = await _api.getById(id);

    _currentPatient = Patient.fromJson(patientMap);

    print(_currentPatient.toJson().toString());

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentPatient.toJson());
    if (code == 201) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
        await _api.put(_currentPatient.toJson(), _currentPatient.id.toString());
    print(_currentPatient.toJson().toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  void updatePatientPhone() {
    _currentPatient.patientPhone.forEach((element) {
      patientPhoneModel.editPatientPhone(element);
      print(element.toJson().toString());
      if (element.id == 0) {
        patientPhoneModel.create();
      } else {
        patientPhoneModel.update();
      }
    });
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentPatient.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }
}
