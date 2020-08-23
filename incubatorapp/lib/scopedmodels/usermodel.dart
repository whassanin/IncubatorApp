import 'package:huawei_account/auth/auth_huawei_id.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';
import 'package:huawei_account/helpers/scope.dart';
import 'package:huawei_account/hms_account.dart';
import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/user.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:scoped_model/scoped_model.dart';

enum UserProvider {huawei,other}

class UserModel extends Model {
  Api _api = new Api('user');

  User _currentUser;

  User get currentUser => _currentUser;

  String confirmPassword;

  void createUser() {
    _currentUser = new User(0, '', '', '','','', DateTime.now());
  }

  void editUser(User editUser) {
    _currentUser = editUser;
  }

  void setEmail(String val) {
    _currentUser.email = val;
  }

  String getEmail() {
    return _currentUser.email;
  }

  void setPassword(String val) {
    _currentUser.password = val;
  }

  String getPassword() {
    return _currentUser.password;
  }

  void setPhone(String val) {
    _currentUser.phone = val;
  }

  String getPhone() {
    return _currentUser.phone;
  }

  void setProvider(UserProvider userProvider) {
    _currentUser.provider = userProvider.toString();
  }

  String getProvider() {
    return _currentUser.provider;
  }

  int getId() {
    return _currentUser.id;
  }

  void setUserType(UserType userType) {
    _currentUser.userType = userType.toString();
  }

  String getUserType() {
    return _currentUser.userType;
  }

  void setPermission() {
    UserType userType;
    if (_currentUser.userType.toString() == UserType.doctor.toString()) {
      userType = UserType.doctor;
    } else if (_currentUser.userType.toString() == UserType.nurse.toString()) {
      userType = UserType.nurse;
    } else if (_currentUser.userType.toString() == UserType.patient.toString()) {
      userType = UserType.patient;
    }
    userPermission.setPermission(userType);
  }

  Future<bool> checkEmail(String email,bool isGet) async {
    bool isTaken = false;

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('email');
    values.add(email);

    List<dynamic> userListMap = await _api.filter(fields, values);
    List<User> userList = userListMap.map((e) => User.fromJson(e)).toList();

    if (userList != null) {
      if (userList.length > 0) {
        print(userList[0].toJson().toString());
        if (isGet == true) {
          User user = userList[0];
          _currentUser = user;
          print('check email:'+_currentUser.email);
        }
        isTaken = true;
      }
    }

    return isTaken;
  }

  void silentSignIn() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    try {
      final AuthHuaweiId accountInfo =
          await HmsAccount.silentSignIn(authParamHelper);
      print(accountInfo.displayName);
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }

  Future<String> signIn() async {
    // BUILD DESIRED PARAMS
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper
      ..setIdToken()
      ..setAuthorizationCode()
      ..setAccessToken()
      ..setProfile()
      ..setEmail()
      ..setId()
      ..addToScopeList([Scope.openId])
      ..setRequestCode(8888);
    // GET ACCOUNT INFO FROM PLUGIN

    print('sign in here huawei');

    try {
      final AuthHuaweiId accountInfo = await HmsAccount.signIn(authParamHelper);
      return accountInfo.email;
    } on Exception catch (exception) {
      print('Here exception');
      print(exception.toString());
    }

    /// TO VERIFY ID TOKEN, AuthParamHelper()..setIdToken()
    //performServerVerification(accountInfo.idToken);

    return null;
  }

  void readByEmailAndPassword() async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('email');
    values.add(_currentUser.email);

    fields.add('password');
    values.add(_currentUser.password);

    List<dynamic> userListMap = await _api.filter(fields, values);
    List<User> userList = userListMap.map((e) => User.fromJson(e)).toList();

    if (userList != null) {
      if (userList.length > 0) {
        _currentUser = userList[0];
        print(_currentUser.toJson().toString());
      }
    }

    setPermission();

    //notifyListeners();
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
