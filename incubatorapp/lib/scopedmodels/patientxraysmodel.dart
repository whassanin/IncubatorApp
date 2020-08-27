import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:scoped_model/scoped_model.dart';

class PatientXRayModel extends Model{
  Api _api = new Api('patientxray');

  Api _apiReverse = new Api('xraypatient');

  List<PatientXRay> patientXRayList;

  PatientXRay _currentPatientXRay;

  PatientXRay get patientXRay => _currentPatientXRay;

  void createPatientXRay() {
    _currentPatientXRay = new PatientXRay(0, 0, 0, '', DateTime.now());
  }

  void editPatientXRay(PatientXRay editPatientXRay) {
    _currentPatientXRay = editPatientXRay;
  }

  void clearList(){
    if(patientXRayList!=null){
      if(patientXRayList.length > 0){
        patientXRayList.clear();
        notifyListeners();
      }
    }
  }


  void setPatientId(int patientId){
    _currentPatientXRay.patientId = patientId;
  }

  int getPatientId(){
    return _currentPatientXRay.patientId;
  }

  void setXRayId(int xrayId){
    _currentPatientXRay.xRayId = xrayId;
  }

  int getXRayId(){
    return _currentPatientXRay.xRayId;
  }

  void setComment(String comment){
    _currentPatientXRay.comment = comment;
  }

  String getComment(){
    return _currentPatientXRay.comment;
  }

  DateTime getCreatedDate(){
    return _currentPatientXRay.createdDate;
  }

  void readByPatientId(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());


    List<dynamic> patientXRayMap = await _api.filter(fields, values);
    patientXRayList = patientXRayMap.map((e) => PatientXRay.fromJson(e)).toList();
    notifyListeners();
  }

  void readByXRayId(int xRayId) async {

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('xRayId');
    values.add(xRayId.toString());

    List<dynamic> patientXRayMap = await _apiReverse.filter(fields, values);
    patientXRayMap.forEach((element) {print(element);});
    patientXRayList = patientXRayMap.map((e) => PatientXRay.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async{
    int code = await _api.post(_currentPatientXRay.toJson());
    if (code == 201) {
      patientXRayList.add(_currentPatientXRay);
      notifyListeners();
      readByPatientId(patientModel.currentPatient.userId);
      return true;
    }
    return false;
  }

  Future<bool> update() async{
    int code = await _api.put(
        _currentPatientXRay.toJson(), _currentPatientXRay.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async{
    int code = await _api.delete(_currentPatientXRay.id.toString());

    if (code == 204) {
      patientXRayList.remove(_currentPatientXRay);
      notifyListeners();

      return true;
    }
    return false;
  }

}