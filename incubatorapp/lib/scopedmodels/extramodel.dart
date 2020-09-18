import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/extra.dart' as extraName;
import 'package:scoped_model/scoped_model.dart';

class ExtraModel extends Model{
  Api _api = new Api('extra');

  List<extraName.Extra> extraList;

  extraName.Extra _currentExtra;

  extraName.Extra get currentExtra => _currentExtra;

  void createExtra(){
    _currentExtra = new extraName.Extra(0, '',0);
  }

  void editExtra(extraName.Extra editExtra){
    _currentExtra = editExtra;
  }

  void setName(String val){
    _currentExtra.name = val;
    notifyListeners();
  }

  String getName(){
    return _currentExtra.name;
  }

  void setPrice(double val){
    _currentExtra.price = val;
  }

  double getPrice(){
    return _currentExtra.price;
  }

  void readAll() async{
    List<dynamic> extraListMap = await _api.get();
    extraList = extraListMap.map((e) => extraName.Extra.fromJson(e)).toList();
    notifyListeners();
  }

  void search(){

  }

  Future<bool> create() async{
    int code = await _api.post(_currentExtra.toJson());
    if (code == 201) {
      extraList.add(_currentExtra);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async{
    int code = await _api.put(
        _currentExtra.toJson(), _currentExtra.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async{
    int code = await _api.delete(_currentExtra.id.toString());

    if (code == 204) {
      extraList.remove(_currentExtra);
      notifyListeners();

      return true;
    }
    return false;
  }

}