enum UserType {patient,doctor,nurse}
class UserPermission{
  UserType userType;
  bool _isPatient = false;
  bool _isDoctor = false;
  bool _isNurse = false;

  bool get isPatient =>_isPatient;
  bool get isDoctor => _isDoctor;
  bool get isNurse =>_isNurse;

  void setPermission(UserType currentUserType){
    userType = currentUserType;
    if(userType == UserType.doctor){
      _isPatient = false;
      _isDoctor = true;
      _isNurse = false;
    }
    else if(userType == UserType.nurse){
      _isPatient = false;
      _isDoctor = false;
      _isNurse = true;
    }
    else if(userType == UserType.patient){
      _isPatient = true;
      _isDoctor = false;
      _isNurse = false;
    }
  }
}