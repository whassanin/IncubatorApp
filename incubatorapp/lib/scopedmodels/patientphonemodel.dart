import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/patientphone.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientPhoneModel extends Model{
  Api _api = new Api('patientphone');

  PatientPhone patientPhone;

  void createPatientPhone(){
    patientPhone = new PatientPhone(0, '', 0);
  }

  void editPatientPhone(PatientPhone editPatientPhone){
    patientPhone = editPatientPhone;
  }

  void setPhone(String phone){
    patientPhone.phone = phone;
  }

  String getPhone(){
    return patientPhone.phone;
  }

  void setPatientId(int patientId){
    patientPhone.patientId = patientId;
  }

  int getPatientId(){
    return patientPhone.patientId;
  }

  Future<bool> create() async {
    int code = await _api.post(patientPhone.toJson());
    if (code == 201) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(patientPhone.toJson(), patientPhone.id.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(patientPhone.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }
}