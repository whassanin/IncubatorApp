import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/incubator.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorModel extends Model {
  Api _api = new Api('incubator');

  List<Incubator> incubatorList;

  Incubator _currentIncubator;

  void createIncubator() {
    _currentIncubator = new Incubator(0, '');
  }

  void editIncubator(Incubator editIncubator) {
    _currentIncubator = editIncubator;
  }

  void setName(String val) {
    _currentIncubator.name = val;
    notifyListeners();
  }

  String getName() {
    return _currentIncubator.name;
  }

  void readAll() async {
    List<dynamic> incubatorListMap = await _api.get();
    incubatorList = incubatorListMap.map((e) => Incubator.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentIncubator.toJson());
    if (code == 201) {
      incubatorList.add(_currentIncubator);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentIncubator.toJson(), _currentIncubator.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentIncubator.id.toString());

    if (code == 204) {
      incubatorList.remove(_currentIncubator);
      notifyListeners();

      return true;
    }
    return false;
  }

}
