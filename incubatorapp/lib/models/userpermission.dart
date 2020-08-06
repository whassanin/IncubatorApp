enum UserType {patient,doctor,nurse,frontDesk}
class UserPermission{
  UserType _userType;
  bool _isPatient = false;
  bool _isDoctor = false;
  bool _isNurse = false;
  bool _isFrontDesk = false;

  bool get isPatient =>_isPatient;
  bool get isDoctor => _isDoctor;
  bool get isNurse =>_isNurse;
  bool get isFrontDesk => _isFrontDesk;

  void setPermission(UserType currentUserType){
    _userType = currentUserType;
    if(_userType == UserType.doctor){
      _isPatient = false;
      _isDoctor = true;
      _isNurse = false;
      _isFrontDesk = false;
    }
    else if(_userType == UserType.nurse){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = true;
      _isFrontDesk = false;
    }
    else if(_userType == UserType.patient){
      _isPatient = true;
      _isDoctor = false;
      _isNurse = false;
      _isFrontDesk = false;
    }
    else if(_userType == UserType.frontDesk){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = false;
      _isFrontDesk = true;
    }
  }
}