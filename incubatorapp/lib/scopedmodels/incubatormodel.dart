import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/incubator.dart';
import 'package:scoped_model/scoped_model.dart';

class IncubatorModel extends Model {
  Api _api = new Api('incubator');

  List<Incubator> incubatorList;

  Incubator currentIncubator;

  void createIncubator() {
    currentIncubator = new Incubator(0, '');
  }

  void setName(String val) {
    currentIncubator.name = val;
    notifyListeners();
  }

  void readAll() async {
    List<dynamic> incubatorListMap = await _api.get();
    incubatorList = incubatorListMap.map((e) => Incubator.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(currentIncubator.toJson());
    if (code == 201) {

      readAll();

      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.post(currentIncubator.toJson());
    if (code == 201) {

      notifyListeners();

      return true;
    }
    return false;
  }

  void delete() {}
}
