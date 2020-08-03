import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:scoped_model/scoped_model.dart';

class ConsumableModel extends Model{
  Api _api = new Api('consumable');

  List<Consumable> consumableList;

  Consumable _currentConsumable;

  void createConsumable(){
    _currentConsumable = new Consumable(0, '',0,0);
  }

  void editConsumable(Consumable editConsumable){
    _currentConsumable = editConsumable;
  }

  void setName(String val){
    _currentConsumable.name = val;
    notifyListeners();
  }

  String getName(){
    return _currentConsumable.name;
  }

  void setAmount(double val){
    _currentConsumable.amount = val;
    notifyListeners();
  }

  double getAmount(){
    return _currentConsumable.amount;
  }

  void setPrice(double val){
    _currentConsumable.price = val;
    notifyListeners();
  }

  double getPrice(){
    return _currentConsumable.price;
  }

  void readAll() async {
    List<dynamic> consumableListMap = await _api.get();
    consumableList = consumableListMap.map((e) => Consumable.fromJson(e)).toList();
    notifyListeners();
  }

  void search(){

  }

  Future<bool> create() async {
    int code = await _api.post(_currentConsumable.toJson());
    if (code == 201) {
      consumableList.add(_currentConsumable);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentConsumable.toJson(), _currentConsumable.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentConsumable.id.toString());

    if (code == 204) {
      consumableList.remove(_currentConsumable);
      notifyListeners();

      return true;
    }
    return false;
  }

}