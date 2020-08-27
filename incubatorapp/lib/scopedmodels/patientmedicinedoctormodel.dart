import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientMedicineDoctorModel extends Model {
  Api _api = new Api('patientmedicinedoctor');

  List<PatientMedicineDoctor> patientMedicineDoctorList;

  PatientMedicineDoctor _currentPatientMedicineDoctor;

  PatientMedicineDoctor get currentPatientMedicineDoctor =>
      _currentPatientMedicineDoctor;

  void createPatientMedicineDoctor() {
    _currentPatientMedicineDoctor =
        new PatientMedicineDoctor(0, 0, 0, 0, 0, DateTime.now());
  }

  void editPatientMedicineDoctor(
      PatientMedicineDoctor editPatientMedicineDoctor) {
    _currentPatientMedicineDoctor = editPatientMedicineDoctor;
  }

  void clearList() {
    if (patientMedicineDoctorList != null) {
      if (patientMedicineDoctorList.length > 0) {
        patientMedicineDoctorList.clear();
        notifyListeners();
      }
    }
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
  }

  int getMedicineId() {
    return _currentPatientMedicineDoctor.medicineId;
  }

  void setQuantity(int quantity) {
    _currentPatientMedicineDoctor.quantity = quantity;
  }

  int getQuantity() {
    return _currentPatientMedicineDoctor.quantity;
  }

  DateTime getCreatedDate() {
    return _currentPatientMedicineDoctor.createdDate;
  }

  void readByPatientId(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> patientAnalysisMap = await _api.filter(fields, values);
    patientMedicineDoctorList = patientAnalysisMap
        .map((e) => PatientMedicineDoctor.fromJson(e))
        .toList();

    notifyListeners();
  }

  void readByMedicineId() {}

  void readByDoctorId() {}

  Future<bool> create() async {
    int code = await _api.post(_currentPatientMedicineDoctor.toJson());
    if (code == 201) {
      patientMedicineDoctorList.add(_currentPatientMedicineDoctor);
      notifyListeners();
      readByPatientId(patientModel.currentPatient.userId);
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
