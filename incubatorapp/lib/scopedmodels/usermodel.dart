import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  Api _api =new Api('user');

  User _currentUser;

  User get currentUser => _currentUser;

  void createUser(){
    _currentUser = new User(0,'','','',DateTime.now());
  }

  void editUser(User editUser){
    _currentUser = editUser;
  }

  void setUsername(String val){
    _currentUser.username = val;
  }

  String getUsername(){
    return _currentUser.username;
  }

  void setPassword(String val){
    _currentUser.password = val;
  }

  String getPassword(){
    return _currentUser.password;
  }

  void setUserType(String val){
    _currentUser.userType = val;
  }

  String getUserType(){
    return _currentUser.userType;
  }

  int getId(){
    return _currentUser.id;
  }

  void readByUsernameAndPassword() async{
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('username');
    values.add(_currentUser.username);

    fields.add('password');
    values.add(_currentUser.password);

    List<dynamic> userListMap =
        await _api.filterByNonForeignKey(fields, values);
    List<User> userList = userListMap.map((e) => User.fromJson(e)).toList();

    if(userList!=null){
      if(userList.length > 0){
        _currentUser = userList[0];
        print(_currentUser.toJson().toString());
      }
    }

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentUser.toJson());
    if (code == 201) {

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
    await _api.put(_currentUser.toJson(), _currentUser.id.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentUser.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }
}