import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCardModel extends Model {
  Api _api = new Api('creditcard');

  bool isAdding = false;

  bool _isPayment = false;

  bool get isPayment => _isPayment;

  CreditCard _currentCreditCard;

  List<CreditCard> creditCardList = [];

  CreditCard get currentCreditCard => _currentCreditCard;

  void setIsPayment(bool val) {
    _isPayment = val;
    notifyListeners();
  }

  void createCreditCard() {
    _currentCreditCard = new CreditCard(0, '', '', 0, 0, 0, DateTime.now());
  }

  void editCreditCard(CreditCard editCreditCard) {
    _currentCreditCard = editCreditCard;
  }

  void setNumber(String val) {
    _currentCreditCard.number = val;
    notifyListeners();
  }

  String _displayNumber(){
    String number = '';

    for (int i = 0; i < _currentCreditCard.number.length - 4; i++) {
      int v = int.tryParse(_currentCreditCard.number[i]);
      if (v == null) {
        number += '  ';
      } else {
        number += 'x';
      }
    }

    for (int i = _currentCreditCard.number.length - 4;
    i < _currentCreditCard.number.length;
    i++) {
      number += _currentCreditCard.number[i];
    }
    return number;
  }

  String getNumber(bool isDisplay) {
    if(isDisplay){
      return _displayNumber();
    }
    return _currentCreditCard.number;
  }

  void setHolder(String val) {
    _currentCreditCard.holder = val;
    notifyListeners();
  }

  String getHolder() {
    return _currentCreditCard.holder;
  }

  void setExpireMonth(int val) {
    _currentCreditCard.expireMonth = val;
    notifyListeners();
  }

  int getExpireMonth() {
    return _currentCreditCard.expireMonth;
  }

  void setExpireYear(int val) {
    _currentCreditCard.expireYear = val;
    notifyListeners();
  }

  int getExpireYear() {
    return _currentCreditCard.expireYear;
  }

  void setPatientId(int val) {
    _currentCreditCard.patientId = val;
    notifyListeners();
  }

  int getPatientId() {
    return _currentCreditCard.patientId;
  }

  DateTime get createDate => _currentCreditCard.createdDate;

  bool validateDate() {
    bool isCheck = false;

    int cm = DateTime.now().month;
    int cy = DateTime.now().year;
    int m = _currentCreditCard.expireMonth;
    int y = _currentCreditCard.expireYear;

    if (y > cy) {
      isCheck = true;
    } else {
      if (y == cy) {
        if (m >= cm) {
          isCheck = true;
        }
      }
    }

    return isCheck;
  }

  void setIsAdding(bool val){
    isAdding = val;
    if(isAdding==false){
      readByPatientId(patientModel.currentPatient.userId);
    }
    notifyListeners();
  }

  Future<List<CreditCard>> readByPatientId(int patientId) async {
    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> creditCardListMap = await _api.filter(fields, values);
    creditCardList =
        creditCardListMap.map((e) => CreditCard.fromJson(e)).toList();

    notifyListeners();

    return creditCardList;
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
