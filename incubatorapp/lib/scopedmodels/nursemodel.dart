import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/nurse.dart';
import 'package:scoped_model/scoped_model.dart';

class NurseModel extends Model{

  Api _api = new Api('nurse');

  List<Nurse> doctorList;

  Nurse _currentNurse;

  Nurse get currentNurse => _currentNurse;

  int _currentTab = 0;

  int get currentTab =>_currentTab;

  void setCurrentTab(int v){
    _currentTab = v;
    notifyListeners();
  }

  void createNurse(){
    _currentNurse = new Nurse(0, '', '', true, DateTime.now(), '', '', DateTime.now());
  }

  void editNurse(Nurse editNurse) {
    _currentNurse = editNurse;
  }

  void setFirstName(String val) {
    _currentNurse.firstName = val;
    notifyListeners();
  }

  String getFirstName() {
    return _currentNurse.firstName;
  }

  void setLastName(String val) {
    _currentNurse.lastName = val;
    notifyListeners();
  }

  String getLastName() {
    return _currentNurse.lastName;
  }

  void setGender(bool val) {
    _currentNurse.gender = val;
    notifyListeners();
  }

  bool getGender() {
    return _currentNurse.gender;
  }

  void setDateOfBirth(DateTime val) {
    _currentNurse.dateOfBirth = val;
    notifyListeners();
  }

  DateTime getDateOfBirth() {
    return _currentNurse.dateOfBirth;
  }

  void setUserName(String val) {
    _currentNurse.username = val;
    notifyListeners();
  }

  String getUserName() {
    return _currentNurse.username;
  }

  void setPassword(String val) {
    _currentNurse.password = val;
    notifyListeners();
  }

  String getPassword() {
    return _currentNurse.password;
  }

  void setCreatedDate(DateTime val) {
    _currentNurse.createdDate = val;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentNurse.createdDate;
  }

  void readAll(){

  }

  void readById(String id) async {
    Map<String, dynamic> doctorMap = await _api.getById(id);

    _currentNurse = Nurse.fromJson(doctorMap);

    notifyListeners();
  }

  void searchByName(){

  }


  Future<bool> create() async {
    int code = await _api.post(_currentNurse.toJson());
    if (code == 201) {

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(_currentNurse.toJson(), _currentNurse.id.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentNurse.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }

}