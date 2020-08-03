import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:scoped_model/scoped_model.dart';

class MedicineModel extends Model{

  Api _api = new Api('medicine');

  List<Medicine> medicineList;

  Medicine _currentMedicine;

  void createMedicine(){
    _currentMedicine = new Medicine(0, '',0,0);
  }

  void editMedicine(Medicine editMedicine){
    _currentMedicine = editMedicine;
  }

  void setName(String val){
    _currentMedicine.name = val;
    notifyListeners();
  }

  String getName(){
    return _currentMedicine.name;
  }

  void setAmount(double val){
    _currentMedicine.amount = val;
    notifyListeners();
  }

  double getAmount(){
    return _currentMedicine.amount;
  }

  void setPrice(double val){
    _currentMedicine.price = val;
    notifyListeners();
  }

  double getPrice(){
    return _currentMedicine.price;
  }

  void readAll() async {
    List<dynamic> medicineListMap = await _api.get();
    medicineList = medicineListMap.map((e) => Medicine.fromJson(e)).toList();
    notifyListeners();
  }

  void search(){

  }

  Future<bool> create() async {
    int code = await _api.post(_currentMedicine.toJson());
    if (code == 201) {
      medicineList.add(_currentMedicine);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentMedicine.toJson(), _currentMedicine.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentMedicine.id.toString());

    if (code == 204) {
      medicineList.remove(_currentMedicine);
      notifyListeners();

      return true;
    }
    return false;
  }

}