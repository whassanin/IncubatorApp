import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/reportproblem.dart';
import 'package:scoped_model/scoped_model.dart';

class ReportProblemModel extends Model{
  Api _api = new Api('reportproblem');

  List<ReportProblem> reportProblemList;

  ReportProblem _currentReportProblem;

  ReportProblem get currentReportProblem => _currentReportProblem;

  void createReportProblem(){
    _currentReportProblem = new ReportProblem(0,'','','w.hassanin@gmail.com','','Opened', DateTime.now());
  }

  void editReportProblem(ReportProblem editReportProblem){
    _currentReportProblem = editReportProblem;
  }

  void setSubject(String val){
    _currentReportProblem.subject = val;
    notifyListeners();
  }

  String getSubject(){
    return _currentReportProblem.subject;
  }

  void setBody(String val){
    _currentReportProblem.body = val;
    notifyListeners();
  }

  String getBody(){
    return _currentReportProblem.body;
  }

  void setMailFrom(String val){
    _currentReportProblem.mailFrom = val;
    notifyListeners();
  }

  String getMailFrom(){
    return _currentReportProblem.mailFrom;
  }

  void setStatus(String val){
    _currentReportProblem.status = val;
    notifyListeners();
  }

  String getStatus(){
    return _currentReportProblem.status;
  }

  DateTime geCreatedDate(){
    return _currentReportProblem.createdDate;
  }

  void readAll() async {
    List<dynamic> reportProblemListMap = await _api.get();
    reportProblemList = reportProblemListMap.map((e) => ReportProblem.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentReportProblem.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentReportProblem.toJson(), _currentReportProblem.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentReportProblem.id.toString());

    if (code == 204) {
      reportProblemList.remove(_currentReportProblem);
      notifyListeners();

      return true;
    }
    return false;
  }

}