import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/shift.dart';
import 'package:scoped_model/scoped_model.dart';

class ShiftModel extends Model{

  Api _api = new Api('shift');

  List<Shift> shiftList;

  Shift _currentShift;

  void createShift() {
    _currentShift = new Shift(0, DateTime.now(),DateTime.now());
  }

  void editShift(Shift editShift) {
    _currentShift = editShift;
  }

  void setStartDate(DateTime val) {
    _currentShift.startDate= val;
    notifyListeners();
  }

  DateTime getStartDate() {
    return _currentShift.startDate;
  }

  void setEndDate(DateTime val) {
    _currentShift.endDate= val;
    notifyListeners();
  }

  DateTime getEndDate() {
    return _currentShift.endDate;
  }

  void readAll() async {
    List<dynamic> shiftListMap = await _api.get();
    shiftList = shiftListMap.map((e) => Shift.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentShift.toJson());
    if (code == 201) {
      shiftList.add(_currentShift);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentShift.toJson(), _currentShift.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentShift.id.toString());

    if (code == 204) {
      shiftList.remove(_currentShift);
      notifyListeners();

      return true;
    }
    return false;
  }


}