enum UserType {patient,doctor,nurse,accountant,none}
class UserPermission{
  UserType _userType;
  bool _isPatient = false;
  bool _isDoctor = false;
  bool _isNurse = false;
  bool _isAccountant = false;

  bool get isPatient =>_isPatient;
  bool get isDoctor => _isDoctor;
  bool get isNurse =>_isNurse;
  bool get isAccountant => _isAccountant;

  void setPermission(UserType currentUserType){
    _userType = currentUserType;
    if(_userType == UserType.doctor){
      _isPatient = false;
      _isDoctor = true;
      _isNurse = false;
      _isAccountant = false;
    }
    else if(_userType == UserType.nurse){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = true;
      _isAccountant = false;
    }
    else if(_userType == UserType.patient){
      _isPatient = true;
      _isDoctor = false;
      _isNurse = false;
      _isAccountant = false;
    }
    else if(_userType == UserType.accountant){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = false;
      _isAccountant = true;
    }else if(_userType == UserType.none){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = false;
      _isAccountant = false;
    }
  }
}