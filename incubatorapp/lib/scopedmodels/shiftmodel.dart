import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/shift.dart';
import 'package:scoped_model/scoped_model.dart';

class ShiftModel extends Model{

  Api _api = new Api('shift');

  List<Shift> shiftList = [];

  Shift _currentShift;

  Shift get currentShift => _currentShift;

  void createShift() {
    _currentShift = new Shift(0,'',0,true,0,false);
  }

  void editShift(Shift editShift) {
    _currentShift = editShift;
  }

  void setName(String val){
    _currentShift.name = val;
    notifyListeners();
  }

  String getName(){
    return _currentShift.name;
  }

  void setStartTime(int val) {
    _currentShift.startTime= val;
    notifyListeners();
  }

  int getStartTime() {
    return _currentShift.startTime;
  }

  void setIsStartTimePM(bool val){
    _currentShift.isStartTimePM = val;
    notifyListeners();
  }

  bool getIsStartTimePM(){
    return _currentShift.isStartTimePM;
  }

  void setEndTime(int val) {
    _currentShift.endTime= val;
    notifyListeners();
  }

  int getEndTime() {
    return _currentShift.endTime;
  }

  void setIsEndTimePM(bool val){
    _currentShift.isEndTimePM = val;
    notifyListeners();
  }

  bool getIsEndTimePM(){
    return _currentShift.isEndTimePM;
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