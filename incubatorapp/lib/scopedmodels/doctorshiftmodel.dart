import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/doctorshift.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math';

class DoctorShiftModel extends Model {
  Api _api = new Api('doctorshift');

  List<DoctorShift> doctorShiftList;

  DoctorShift _currentDoctorShift;

  DoctorShift get currentDoctorShift => _currentDoctorShift;

  void createDoctorShift() {
    DateTime currentDate = DateTime.now();
    _currentDoctorShift = new DoctorShift(0, 0, 0, currentDate, false,
        currentDate, false, currentDate, currentDate);
  }

  void editDoctorShift(DoctorShift editDoctorShift) {
    _currentDoctorShift = editDoctorShift;
  }

  void setDoctorId(int doctorId) {
    _currentDoctorShift.doctorId = doctorId;
    notifyListeners();
  }

  int getDoctorId() {
    return _currentDoctorShift.doctorId;
  }

  void setShiftId(int shiftId) {
    _currentDoctorShift.shiftId = shiftId;
    notifyListeners();
  }

  int getShiftId() {
    return _currentDoctorShift.shiftId;
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
    _currentDoctorShift.isSignedIn = false;
    _currentDoctorShift.isSignedOut = false;
    _currentDoctorShift.startDateTime = current;
    _currentDoctorShift.endDateTime = current;
    notifyListeners();
  }

  void setStartDateTime(DateTime dateTime) {
    _currentDoctorShift.isSignedIn = true;
    _currentDoctorShift.startDateTime = dateTime;
    notifyListeners();
  }

  DateTime getStartDateTime() {
    return _currentDoctorShift.startDateTime;
  }

  void setEndDateTime(DateTime dateTime) {
    _currentDoctorShift.isSignedOut = true;
    _currentDoctorShift.endDateTime = dateTime;
    notifyListeners();
  }

  DateTime getEndDateTime() {
    return _currentDoctorShift.endDateTime;
  }

  void setCreatedDateTime(DateTime dateTime) {
    _currentDoctorShift.createdDate = dateTime;
  }

  DateTime getCreatedDateTime() {
    return _currentDoctorShift.createdDate;
  }

  void setChangedDateTime(DateTime dateTime) {
    _currentDoctorShift.changedDate = dateTime;
  }

  DateTime getChangedDateTime() {
    return _currentDoctorShift.changedDate;
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

  void readByDoctorId(int doctorId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('doctorId');
    values.add(doctorId.toString());

    List<dynamic> doctorShiftMap = await _api.filter(fields, values);
    List<DoctorShift> list =
        doctorShiftMap.map((e) => DoctorShift.fromJson(e)).toList();

    List<DoctorShift> notSignedList =
        list.where((element) => element.isSignedIn == false).toList();

    List<DoctorShift> signedList =
        list.where((element) => element.isSignedIn == true).toList();

    if (doctorShiftList == null) {
      doctorShiftList = <DoctorShift>[];
    }
    else {
      if(doctorShiftList.length > 0){
        doctorShiftList.clear();
      }
    }

    notSignedList.forEach((ns) {
      int i = doctorShiftList.indexOf(ns);
      if (i < 0) {
        doctorShiftList.add(ns);
      }
    });

    signedList.forEach((s) {
      int i = doctorShiftList.indexOf(s);
      if (i < 0) {
        doctorShiftList.add(s);
      }
    });

    notifyListeners();
  }

  void readByShiftId(int shiftId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('shiftId');
    values.add(shiftId.toString());

    List<dynamic> doctorShiftMap = await _api.filter(fields, values);
    doctorShiftList =
        doctorShiftMap.map((e) => DoctorShift.fromJson(e)).toList();

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentDoctorShift.toJson());
    if (code == 201) {
      readByDoctorId(_currentDoctorShift.doctorId);
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentDoctorShift.toJson(), _currentDoctorShift.id.toString());

    if (code == 200) {
      readByDoctorId(doctorModel.currentDoctor.userId);

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentDoctorShift.id.toString());

    if (code == 204) {
      doctorShiftList.remove(_currentDoctorShift);
      notifyListeners();

      return true;
    }
    return false;
  }
}
