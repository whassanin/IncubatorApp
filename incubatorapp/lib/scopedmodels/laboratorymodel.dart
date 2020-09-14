import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:scoped_model/scoped_model.dart';

class LaboratoryModel extends Model {
  Api _api = new Api('laboratory');

  List<Laboratory> laboratoryList = [];

  String _searchName;

  String get searchName=>_searchName;

  Laboratory _currentLaboratory;

  Laboratory get currentLaboratory => _currentLaboratory;

  void createLaboratory() {
    _currentLaboratory = new Laboratory(0, '', 0);
  }

  void editLaboratory(Laboratory editLaboratory) {
    _currentLaboratory = editLaboratory;
  }

  void setName(String val) {
    _currentLaboratory.name = val;
    notifyListeners();
  }

  String getName() {
    return _currentLaboratory.name;
  }

  void setPrice(double val) {
    _currentLaboratory.price = val;
  }

  double getPrice() {
    return _currentLaboratory.price;
  }

  void setSearchName(String val) {
    _searchName = val;
    notifyListeners();
  }

  void readAll() async {
    List<dynamic> laboratoryListMap = await _api.get();
    laboratoryList =
        laboratoryListMap.map((e) => Laboratory.fromJson(e)).toList();
    notifyListeners();
  }

  void search(String val) async {
    _searchName = val;
    laboratoryList.clear();
    notifyListeners();

    List<dynamic> laboratoryListMap = await _api.search(val);
    laboratoryList =
        laboratoryListMap.map((e) => Laboratory.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentLaboratory.toJson());
    if (code == 201) {
      laboratoryList.add(_currentLaboratory);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentLaboratory.toJson(), _currentLaboratory.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentLaboratory.id.toString());

    if (code == 204) {
      laboratoryList.remove(_currentLaboratory);
      notifyListeners();

      return true;
    }
    return false;
  }
}
