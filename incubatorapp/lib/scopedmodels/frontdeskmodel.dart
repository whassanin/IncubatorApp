import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/frontDesk.dart';
import 'package:scoped_model/scoped_model.dart';

class FrontDeskModel extends Model{

  Api _api = new Api('frontdesk');

  List<FrontDesk> frontDeskList;

  FrontDesk _currentFrontDesk;

  FrontDesk get currentFrontDesk => _currentFrontDesk;

  int _currentTab = 0;

  int get currentTab =>_currentTab;

  void setCurrentTab(int v){
    _currentTab = v;
    notifyListeners();
  }

  void createFrontDesk(){
    _currentFrontDesk = new FrontDesk(0, '', '', true, DateTime.now(), DateTime.now());
  }

  void editFrontDesk(FrontDesk editFrontDesk) {
    _currentFrontDesk = editFrontDesk;
  }

  void setFirstName(String val) {
    _currentFrontDesk.firstName = val;
    notifyListeners();
  }

  String getFirstName() {
    return _currentFrontDesk.firstName;
  }

  void setLastName(String val) {
    _currentFrontDesk.lastName = val;
    notifyListeners();
  }

  String getLastName() {
    return _currentFrontDesk.lastName;
  }

  void setGender(bool val) {
    _currentFrontDesk.gender = val;
    notifyListeners();
  }

  bool getGender() {
    return _currentFrontDesk.gender;
  }

  void setDateOfBirth(DateTime val) {
    _currentFrontDesk.dateOfBirth = val;
    notifyListeners();
  }

  DateTime getDateOfBirth() {
    return _currentFrontDesk.dateOfBirth;
  }

  void setUserId(int userId){
    _currentFrontDesk.userId = userId;
    notifyListeners();
  }

  int getUserId(){
    return _currentFrontDesk.userId;
  }

  void setCreatedDate(DateTime val) {
    _currentFrontDesk.createdDate = val;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentFrontDesk.createdDate;
  }

  void readAll(){

  }

  void readById(String id) async {
    Map<String, dynamic> frontDeskMap = await _api.getById(id);

    _currentFrontDesk = FrontDesk.fromJson(frontDeskMap);

    notifyListeners();
  }

  void searchByName(){

  }


  Future<bool> create() async {
    int code = await _api.post(_currentFrontDesk.toJson());
    if (code == 201) {

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(_currentFrontDesk.toJson(), _currentFrontDesk.userId.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentFrontDesk.userId.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }

}