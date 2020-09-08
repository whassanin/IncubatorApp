import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/analysis.dart' as analysisName;
import 'package:scoped_model/scoped_model.dart';

class AnalysisModel extends Model {
  Api _api = new Api('analysis');

  List<analysisName.Analysis> analysisList = [];

  List<analysisName.Analysis> searchList = [];

  analysisName.Analysis _currentAnalysis;

  void createAnalysis() {
    _currentAnalysis = new analysisName.Analysis(0, '', 0);
  }

  void editAnalysis(analysisName.Analysis editAnalysis) {
    _currentAnalysis = editAnalysis;
  }

  void setName(String val) {
    _currentAnalysis.name = val;
    notifyListeners();
  }

  String getName() {
    return _currentAnalysis.name;
  }

  void setPrice(double val) {
    _currentAnalysis.price = val;
  }

  double getPrice() {
    return _currentAnalysis.price;
  }

  void readAll() async {
    List<dynamic> analysisListMap = await _api.get();
    analysisList =
        analysisListMap.map((e) => analysisName.Analysis.fromJson(e)).toList();
    notifyListeners();
  }

  void search(String val) {
    print(val);
    if (val.isNotEmpty) {
      searchList =
          analysisList.where((element) => element.name.contains(val)).toList();
      print(searchList.length);
    }else {
      searchList.clear();
    }
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentAnalysis.toJson());
    if (code == 201) {
      analysisList.add(_currentAnalysis);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentAnalysis.toJson(), _currentAnalysis.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentAnalysis.id.toString());

    if (code == 204) {
      analysisList.remove(_currentAnalysis);
      notifyListeners();

      return true;
    }
    return false;
  }
}
