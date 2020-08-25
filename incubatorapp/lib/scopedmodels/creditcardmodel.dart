import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCardModel extends Model{
  Api _api = new Api('creditcard');

  CreditCard _currentCreditCard;

  List<CreditCard> creditCardList;

  CreditCard get currentCreditCard => _currentCreditCard;

  void createCreditCard(){
    _currentCreditCard = new CreditCard(0,'','',0,0,0,DateTime.now());
  }

  void editCreditCard(CreditCard editCreditCard){
    _currentCreditCard = editCreditCard;
  }

  void setNumber(String val){
    _currentCreditCard.number = val;
    notifyListeners();
  }

  String getNumber(){
    return _currentCreditCard.number;
  }

  void setHolder(String val){
    _currentCreditCard.holder = val;
    notifyListeners();
  }

  String getHolder(){
    return _currentCreditCard.holder;
  }

  void setExpireMonth(int val){
    _currentCreditCard.expireMonth = val;
    notifyListeners();
  }

  int getExpireMonth(){
    return _currentCreditCard.expireMonth;
  }

  void setExpireYear(int val){
    _currentCreditCard.expireYear = val;
    notifyListeners();
  }

  int getExpireYear(){
    return _currentCreditCard.expireYear;
  }

  void setPatientId(int val){
    _currentCreditCard.patientId = val;
    notifyListeners();
  }

  int getPatientId(){
    return _currentCreditCard.patientId;
  }

  DateTime get createDate => _currentCreditCard.createdDate;

  void readByPatientId(int patientId) async{
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> creditCardListMap = await _api.filter(fields, values);
    creditCardList = creditCardListMap.map((e) => CreditCard.fromJson(e)).toList();

    await Future.delayed(Duration(seconds: 1));

    notifyListeners();
  }

  Future<bool> create() async {
    int code = await _api.post(_currentCreditCard.toJson());
    if (code == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code = await _api.put(
        _currentCreditCard.toJson(), _currentCreditCard.id.toString());
    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }


  Future<bool> delete() async {
    int code = await _api.delete(_currentCreditCard.id.toString());

    if (code == 204) {
      notifyListeners();

      return true;
    }
    return false;
  }
}