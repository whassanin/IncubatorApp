import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:scoped_model/scoped_model.dart';

class XRayModel extends Model {
  Api _api = new Api('xray');

  List<XRay> xRayList = [];

  String _searchName;

  String get searchName => _searchName;

  XRay _currentXRay;

  XRay get currentXRay => _currentXRay;

  void createXRay() {
    _currentXRay = new XRay(0, '', 0);
  }

  void editXRay(XRay editXRay) {
    _currentXRay = editXRay;
  }

  void setName(String val) {
    _currentXRay.name = val;
    notifyListeners();
  }

  String getName() {
    return _currentXRay.name;
  }

  void setPrice(double val) {
    _currentXRay.price = val;
    notifyListeners();
  }

  double getPrice() {
    return _currentXRay.price;
  }

  void setSearchName(String val) {
    _searchName = val;
    notifyListeners();
  }

  void readAll() async {
    List<dynamic> xRayListMap = await _api.get();
    xRayList = xRayListMap.map((e) => XRay.fromJson(e)).toList();
    notifyListeners();
  }

  void search(String val) async {
    _searchName = val;

    xRayList = xRayList
        .where((element) => element.name.toLowerCase().contains(val))
        .toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentXRay.toJson());
    if (code == 201) {
      xRayList.add(_currentXRay);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
        await _api.put(_currentXRay.toJson(), _currentXRay.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentXRay.id.toString());

    if (code == 204) {
      xRayList.remove(_currentXRay);
      notifyListeners();

      return true;
    }
    return false;
  }
}
