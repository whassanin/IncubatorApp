import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/doctor.dart';
import 'package:scoped_model/scoped_model.dart';

class DoctorModel extends Model{

  Api _api = new Api('doctor');

  List<Doctor> doctorList;

  Doctor _currentDoctor;

  Doctor get currentDoctor => _currentDoctor;

  int _currentTab = 0;

  int get currentTab =>_currentTab;

  void setCurrentTab(int v){
    _currentTab = v;
    notifyListeners();
  }

  void createDoctor(){
    _currentDoctor = new Doctor(0, '', '', true, DateTime.now(), '', '', DateTime.now());
  }

  void editDoctor(Doctor editDoctor) {
    _currentDoctor = editDoctor;
  }

  void setFirstName(String val) {
    _currentDoctor.firstName = val;
    notifyListeners();
  }

  String getFirstName() {
    return _currentDoctor.firstName;
  }

  void setLastName(String val) {
    _currentDoctor.lastName = val;
    notifyListeners();
  }

  String getLastName() {
    return _currentDoctor.lastName;
  }

  void setGender(bool val) {
    _currentDoctor.gender = val;
    notifyListeners();
  }

  bool getGender() {
    return _currentDoctor.gender;
  }

  void setDateOfBirth(DateTime val) {
    _currentDoctor.dateOfBirth = val;
    notifyListeners();
  }

  DateTime getDateOfBirth() {
    return _currentDoctor.dateOfBirth;
  }

  void setUserName(String val) {
    _currentDoctor.username = val;
    notifyListeners();
  }

  String getUserName() {
    return _currentDoctor.username;
  }

  void setPassword(String val) {
    _currentDoctor.password = val;
    notifyListeners();
  }

  String getPassword() {
    return _currentDoctor.password;
  }

  void setCreatedDate(DateTime val) {
    _currentDoctor.createdDate = val;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentDoctor.createdDate;
  }

  void readAll(){

  }

  void readById(String id) async {
    Map<String, dynamic> doctorMap = await _api.getById(id);

    _currentDoctor = Doctor.fromJson(doctorMap);

    notifyListeners();
  }

  void searchByName(){

  }


  Future<bool> create() async {
    int code = await _api.post(_currentDoctor.toJson());
    if (code == 201) {

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(_currentDoctor.toJson(), _currentDoctor.id.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentDoctor.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }

}