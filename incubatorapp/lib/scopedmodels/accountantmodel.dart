import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/accountant.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountantModel extends Model{

  Api _api = new Api('accountant');

  List<Accountant> accountantList = [];

  Accountant _currentAccountant;

  Accountant get currentAccountant => _currentAccountant;

  int _currentTab = 0;

  int get currentTab =>_currentTab;

  void setCurrentTab(int v){
    _currentTab = v;
    notifyListeners();
  }

  void createAccountant(){
    _currentAccountant = new Accountant(0, '', '', true, DateTime.now(), DateTime.now());
  }

  void editAccountant(Accountant editAccountant) {
    _currentAccountant = editAccountant;
  }

  void setFirstName(String val) {
    _currentAccountant.firstName = val;
    notifyListeners();
  }

  String getFirstName() {
    return _currentAccountant.firstName;
  }

  void setLastName(String val) {
    _currentAccountant.lastName = val;
    notifyListeners();
  }

  String getLastName() {
    return _currentAccountant.lastName;
  }

  void setGender(bool val) {
    _currentAccountant.gender = val;
    notifyListeners();
  }

  bool getGender() {
    return _currentAccountant.gender;
  }

  void setDateOfBirth(DateTime val) {
    _currentAccountant.dateOfBirth = val;
    notifyListeners();
  }

  DateTime getDateOfBirth() {
    return _currentAccountant.dateOfBirth;
  }

  void setUserId(int userId){
    _currentAccountant.userId = userId;
    notifyListeners();
  }

  int getUserId(){
    return _currentAccountant.userId;
  }

  void setCreatedDate(DateTime val) {
    _currentAccountant.createdDate = val;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentAccountant.createdDate;
  }

  void readAll(){

  }

  void readById(String id) async {
    Map<String, dynamic> frontDeskMap = await _api.getById(id);

    _currentAccountant = Accountant.fromJson(frontDeskMap);

    notifyListeners();
  }

  void searchByName(){

  }


  Future<bool> create() async {
    int code = await _api.post(_currentAccountant.toJson());
    if (code == 201) {

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(_currentAccountant.toJson(), _currentAccountant.userId.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentAccountant.userId.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }

}