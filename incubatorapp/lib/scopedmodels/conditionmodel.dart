import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/condition.dart' as conditionName;
import 'package:scoped_model/scoped_model.dart';

class ConditionModel extends Model{
  Api _api = new Api('condition');

  List<conditionName.Condition> conditionList;

  conditionName.Condition _currentCondition;

  void createCondition(){
    _currentCondition = new conditionName.Condition(0, '', 0);
  }

  void editCondition(conditionName.Condition editCondition){
    _currentCondition = editCondition;
  }

  void setName(String name){
    _currentCondition.name = name;
    notifyListeners();
  }

  String getName(){
    return _currentCondition.name;
  }

  void setCost(double cost){
    _currentCondition.cost = cost;
    notifyListeners();
  }

  double getCost(){
  return _currentCondition.cost;
  }

  void readAll() async{
    List<dynamic> conditionListMap = await _api.get();
    conditionList = conditionListMap.map((e) => conditionName.Condition.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentCondition.toJson());
    if (code == 201) {
      conditionList.add(_currentCondition);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentCondition.toJson(), _currentCondition.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentCondition.id.toString());

    if (code == 204) {
      conditionList.remove(_currentCondition);
      notifyListeners();

      return true;
    }
    return false;
  }

}