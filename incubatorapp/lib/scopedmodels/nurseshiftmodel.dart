import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:scoped_model/scoped_model.dart';

class NurseShiftModel extends Model{

  Api _api = new Api('nurseshift');

  List<NurseShift> nurseShiftList = [];

  NurseShift _currentNurseShift;

  NurseShift get currentNurseShift => _currentNurseShift;

  void createNurseShift() {
    DateTime currentDate = DateTime.now();
    _currentNurseShift = new NurseShift(0, 0, 0, currentDate, false,
        currentDate, false, currentDate, currentDate);
  }

  void editNurseShift(NurseShift editNurseShift) {
    _currentNurseShift = editNurseShift;
  }

  void setNurseId(int nurseId) {
    _currentNurseShift.nurseId = nurseId;
    notifyListeners();
  }

  int getNurseId() {
    return _currentNurseShift.nurseId;
  }

  void setShiftId(int shiftId) {
    _currentNurseShift.shiftId = shiftId;
    notifyListeners();
  }

  int getShiftId() {
    return _currentNurseShift.shiftId;
  }

  void setScheduleDateTime(DateTime dateTime) {
    DateTime currentTime = DateTime.now();
    DateTime current = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      currentTime.hour,
      currentTime.minute,
      currentTime.second,
      currentTime.millisecond,
      currentTime.microsecond,
    );
    _currentNurseShift.isSignedIn = false;
    _currentNurseShift.isSignedOut = false;
    _currentNurseShift.startDateTime = current;
    _currentNurseShift.endDateTime = current;
    notifyListeners();
  }

  void setStartDateTime(DateTime dateTime) {
    _currentNurseShift.isSignedIn = true;
    _currentNurseShift.startDateTime = dateTime;
    notifyListeners();
  }

  DateTime getStartDateTime() {
    return _currentNurseShift.startDateTime;
  }

  void setEndDateTime(DateTime dateTime) {
    _currentNurseShift.isSignedOut = true;
    _currentNurseShift.endDateTime = dateTime;
    notifyListeners();
  }

  DateTime getEndDateTime() {
    return _currentNurseShift.endDateTime;
  }

  void setCreatedDateTime(DateTime dateTime) {
    _currentNurseShift.createdDate = dateTime;
  }

  DateTime getCreatedDateTime() {
    return _currentNurseShift.createdDate;
  }

  void setChangedDateTime(DateTime dateTime) {
    _currentNurseShift.changedDate = dateTime;
  }

  DateTime getChangedDateTime() {
    return _currentNurseShift.changedDate;
  }

  double totalHours(DateTime startDateTime,DateTime endDateTime){
    int sh = startDateTime.hour;
    double sm = startDateTime.minute / 60;
    double ss = startDateTime.second / 3600;

    double startSum = sh+sm+ss;

    int eh = endDateTime.hour;
    double em = endDateTime.minute / 60;
    double es = endDateTime.second / 3600;

    double endSum = eh+em+es;

    double totalTime = endSum - startSum;

    return totalTime.roundToDouble();
  }

  void readByNurseId(int nurseId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('nurseId');
    values.add(nurseId.toString());

    List<dynamic> nurseShiftMap = await _api.filter(fields, values);
    List<NurseShift> list =
    nurseShiftMap.map((e) => NurseShift.fromJson(e)).toList();

    List<NurseShift> notSignedList =
    list.where((element) => element.isSignedIn == false).toList();

    List<NurseShift> signedList =
    list.where((element) => element.isSignedIn == true).toList();

    if (nurseShiftList == null) {
      nurseShiftList = <NurseShift>[];
    }
    else {
      if(nurseShiftList.length > 0){
        nurseShiftList.clear();
      }
    }

    notSignedList.forEach((ns) {
      int i = nurseShiftList.indexOf(ns);
      if (i < 0) {
        nurseShiftList.add(ns);
      }
    });

    signedList.forEach((s) {
      int i = nurseShiftList.indexOf(s);
      if (i < 0) {
        nurseShiftList.add(s);
      }
    });

    notifyListeners();
  }

  void readByShiftId(int shiftId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('shiftId');
    values.add(shiftId.toString());

    List<dynamic> nurseShiftMap = await _api.filter(fields, values);
    nurseShiftList =
        nurseShiftMap.map((e) => NurseShift.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentNurseShift.toJson());
    if (code == 201) {
      readByNurseId(_currentNurseShift.nurseId);
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentNurseShift.toJson(), _currentNurseShift.id.toString());

    if (code == 200) {
      readByNurseId(nurseModel.currentNurse.userId);

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentNurseShift.id.toString());

    if (code == 204) {
      nurseShiftList.remove(_currentNurseShift);
      notifyListeners();

      return true;
    }
    return false;
  }

}