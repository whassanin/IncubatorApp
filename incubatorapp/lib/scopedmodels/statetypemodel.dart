import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/statetype.dart';
import 'package:scoped_model/scoped_model.dart';

class StateTypeModel extends Model {
  Api _api = new Api('statetype');

  List<StateType> stateTypeList = [];

  StateType _currentStateType;

  StateType get currentStateType => _currentStateType;

  void createStateType() {
    _currentStateType = new StateType(0, '');
  }

  void editStateType(StateType editStateType) {
    _currentStateType = editStateType;
  }

  void setName(String val) {
    _currentStateType.name = val;
    notifyListeners();
  }

  String getName() {
    return _currentStateType.name;
  }

  void readAll() async {
    List<dynamic> stateTypeListMap = await _api.get();
    stateTypeList = stateTypeListMap.map((e) => StateType.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentStateType.toJson());
    if (code == 201) {
      stateTypeList.add(_currentStateType);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentStateType.toJson(), _currentStateType.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentStateType.id.toString());

    if (code == 204) {
      stateTypeList.remove(_currentStateType);
      notifyListeners();

      return true;
    }
    return false;
  }

}
