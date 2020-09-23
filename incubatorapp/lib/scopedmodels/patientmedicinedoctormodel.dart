import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientMedicineDoctorModel extends Model {
  Api _api = new Api('patientmedicinedoctor');

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<PatientMedicineDoctor> patientMedicineDoctorList = [];

  PatientMedicineDoctor _currentPatientMedicineDoctor;

  PatientMedicineDoctor get currentPatientMedicineDoctor =>
      _currentPatientMedicineDoctor;

  void createPatientMedicineDoctor() {
    _currentPatientMedicineDoctor =
        new PatientMedicineDoctor(0, 0, 0, 0, 0,'','Pending',DateTime.now(),'Pending', DateTime.now());
  }

  void editPatientMedicineDoctor(
      PatientMedicineDoctor editPatientMedicineDoctor) {
    _currentPatientMedicineDoctor = editPatientMedicineDoctor;
  }

  void setList(List<PatientMedicineDoctor> list){
    patientMedicineDoctorList = list;
    _isLoading = false;
    notifyListeners();
  }

  void setPatientId(int patientId) {
    _currentPatientMedicineDoctor.patientId = patientId;
  }

  int getPatientId() {
    return _currentPatientMedicineDoctor.patientId;
  }

  void setDoctorId(int doctorId) {
    _currentPatientMedicineDoctor.doctorId = doctorId;
  }

  int getDoctorId() {
    return _currentPatientMedicineDoctor.doctorId;
  }

  void setMedicineId(int medicineId) {
    _currentPatientMedicineDoctor.medicineId = medicineId;
    notifyListeners();
  }

  int getMedicineId() {
    return _currentPatientMedicineDoctor.medicineId;
  }

  void setQuantity(int quantity) {
    _currentPatientMedicineDoctor.quantity = quantity;
    notifyListeners();
  }

  int getQuantity() {
    return _currentPatientMedicineDoctor.quantity;
  }

  void setDescription(String val)
  {
    _currentPatientMedicineDoctor.description = val;
    notifyListeners();
  }

  String getDescription(){
    return _currentPatientMedicineDoctor.description;
  }

  void setBillStatus(String val) {
    _currentPatientMedicineDoctor.billStatus = val;
    notifyListeners();
  }

  String getBillStatus() {
    return _currentPatientMedicineDoctor.billStatus;
  }

  DateTime getCreatedDate() {
    return _currentPatientMedicineDoctor.createdDate;
  }

  void setIsLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  void readAll() async {
    List<dynamic> patientMedicineDoctorMap = await _api.get();
    patientMedicineDoctorList =
        patientMedicineDoctorMap.map((e) => PatientMedicineDoctor.fromJson(e)).toList();
    notifyListeners();
  }

  void clearList() {
    _isLoading = true;
    if (patientMedicineDoctorList != null) {
      if (patientMedicineDoctorList.length > 0) {
        patientMedicineDoctorList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<PatientMedicineDoctor>> readByPatientId(int patientId) async {
    clearList();

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientMedicineDoctorMap = await _api.filter(fields, values);
    patientMedicineDoctorList = patientMedicineDoctorMap
        .map((e) => PatientMedicineDoctor.fromJson(e))
        .toList();

    _isLoading = false;
    notifyListeners();

    return patientMedicineDoctorList;
  }

  Future<List<PatientMedicineDoctor>> readByPatientIdAndPendingMedicine(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());
    fields.add('billStatus');
    values.add('Pending');

    List<dynamic> patientMedicineDoctorMap = await _api.filter(fields, values);
    patientMedicineDoctorList =
        patientMedicineDoctorMap.map((e) => PatientMedicineDoctor.fromJson(e)).toList();

    notifyListeners();

    return patientMedicineDoctorList;
  }

  void readByMedicineId() {}

  void readByDoctorId() {}

  Future<bool> create() async {
    int code = await _api.post(_currentPatientMedicineDoctor.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(_currentPatientMedicineDoctor.toJson(),
        _currentPatientMedicineDoctor.id.toString());
    if (code == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code =
        await _api.delete(_currentPatientMedicineDoctor.id.toString());

    if (code == 204) {
      patientMedicineDoctorList.remove(_currentPatientMedicineDoctor);
      notifyListeners();

      return true;
    }
    return false;
  }
}
