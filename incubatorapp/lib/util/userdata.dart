import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/userpermission.dart';
import 'package:incubatorapp/scopedmodels/usermodel.dart';

class UserData {
  void addUserDoctor() async {
    userModel.createUser();
    userModel.setProvider(UserProvider.other);
    userModel.setEmail('naima@gmail.com');
    userModel.setPassword('admin');
    userModel.setPhone('0123456789');
    userModel.setUserType(UserType.doctor);
    userModel.create();

    await Future.delayed(Duration(seconds: 2));

    doctorModel.createDoctor();
    doctorModel.setUserId(1);
    doctorModel.setFirstName('Naima');
    doctorModel.setLastName('AbdelMenam');
    doctorModel.setDateOfBirth(DateTime.now());
    doctorModel.setGender(false);
    doctorModel.create();
  }

  void addUserNurse() async {
    userModel.createUser();
    userModel.setProvider(UserProvider.other);
    userModel.setEmail('radwa@gmail.com');
    userModel.setPassword('admin');
    userModel.setPhone('0123456789');
    userModel.setUserType(UserType.nurse);
    userModel.create();

    await Future.delayed(Duration(seconds: 2));

    nurseModel.createNurse();
    nurseModel.setUserId(2);
    nurseModel.setFirstName('Radwa');
    nurseModel.setLastName('Makhlouf');
    nurseModel.setDateOfBirth(DateTime.now());
    nurseModel.setGender(false);
    nurseModel.create();
  }

  void addUserAccountant() async {
    userModel.createUser();
    userModel.setProvider(UserProvider.other);
    userModel.setEmail('ahmed@gmail.com');
    userModel.setPassword('admin');
    userModel.setPhone('0123456789');
    userModel.setUserType(UserType.accountant);
    userModel.create();

    await Future.delayed(Duration(seconds: 2));

    accountantModel.createAccountant();
    accountantModel.setUserId(3);
    accountantModel.setFirstName('Ahmed');
    accountantModel.setLastName('Hassanin');
    accountantModel.setDateOfBirth(DateTime.now());
    accountantModel.setGender(false);
    accountantModel.create();
  }

  void addUserPatient() {
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('mahmoud@gmail.com');
    userModel.setPassword('mahmoud@1999');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('ibrahim@gmail.com');
    userModel.setPassword('admin');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('yasser@gmail.com');
    userModel.setPassword('yasser@2001');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('adel@gmail.com');
    userModel.setPassword('adel@2002');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('nermen@gmail.com');
    userModel.setPassword('nermen@2003');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('yasmin@gmail.com');
    userModel.setPassword('yasmin@2004');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('mina@gmail.com');
    userModel.setPassword('mina@2005');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('rana@gmail.com');
    userModel.setPassword('rana@2006');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
    userModel.createUser();
    userModel.setUserType(UserType.patient);
    userModel.setEmail('sara@gmail.com');
    userModel.setPassword('sara@2007');
    userModel.setProvider(UserProvider.other);
    userModel.setPhone('+0201019340608');
    userModel.create();
  }

  void addPatientDetailData() {
    patientModel.createPatient();
    patientModel.setMotherName('Nesreen');
    patientModel.setFatherName('Ahmed');
    patientModel.setGender(false);
    patientModel.setDateOfBirth(DateTime.parse('1999-04-01'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(500);
    patientModel.setIsOnLightRay(true);
    patientModel.setUserId(4);
    patientModel.setConditionId(1);
    patientModel.setIncubatorId(1);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Nariman');
    patientModel.setFatherName('Hassan');
    patientModel.setGender(false);
    patientModel.setDateOfBirth(DateTime.parse('2000-05-02'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(600);
    patientModel.setIsOnLightRay(true);
    patientModel.setUserId(5);
    patientModel.setConditionId(2);
    patientModel.setIncubatorId(8);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Sara');
    patientModel.setFatherName('Abdallah');
    patientModel.setGender(false);
    patientModel.setDateOfBirth(DateTime.parse('2001-06-03'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(800);
    patientModel.setIsOnLightRay(true);
    patientModel.setUserId(6);
    patientModel.setConditionId(3);
    patientModel.setIncubatorId(2);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Somya');
    patientModel.setFatherName('Mohamed');
    patientModel.setGender(false);
    patientModel.setDateOfBirth(DateTime.parse('2002-07-04'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(900);
    patientModel.setIsOnLightRay(true);
    patientModel.setUserId(7);
    patientModel.setConditionId(1);
    patientModel.setIncubatorId(10);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Engy');
    patientModel.setFatherName('Salah');
    patientModel.setGender(true);
    patientModel.setDateOfBirth(DateTime.parse('2003-08-05'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(1);
    patientModel.setIsOnLightRay(false);
    patientModel.setUserId(8);
    patientModel.setConditionId(2);
    patientModel.setIncubatorId(7);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Yasmin');
    patientModel.setFatherName('Yousri');
    patientModel.setGender(true);
    patientModel.setDateOfBirth(DateTime.parse('2004-09-06'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(1.5);
    patientModel.setIsOnLightRay(false);
    patientModel.setUserId(9);
    patientModel.setConditionId(3);
    patientModel.setIncubatorId(3);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Mirna');
    patientModel.setFatherName('Micheal');
    patientModel.setGender(true);
    patientModel.setDateOfBirth(DateTime.parse('2005-10-07'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(2);
    patientModel.setIsOnLightRay(false);
    patientModel.setUserId(10);
    patientModel.setConditionId(1);
    patientModel.setIncubatorId(5);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Alyaa');
    patientModel.setFatherName('Ahmed');
    patientModel.setGender(true);
    patientModel.setDateOfBirth(DateTime.parse('2006-11-08'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(2.5);
    patientModel.setIsOnLightRay(false);
    patientModel.setUserId(11);
    patientModel.setConditionId(2);
    patientModel.setIncubatorId(9);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
    patientModel.createPatient();
    patientModel.setMotherName('Dalia');
    patientModel.setFatherName('Mohamed');
    patientModel.setGender(true);
    patientModel.setDateOfBirth(DateTime.parse('2007-12-09'));
    patientModel.setAddress('sheraton');
    patientModel.setWeight(3);
    patientModel.setIsOnLightRay(false);
    patientModel.setUserId(12);
    patientModel.setConditionId(3);
    patientModel.setIncubatorId(6);
    patientModel.setStateTypeId(1);
    patientModel.setSSN('1234567891011');
    patientModel.create();
  }

  void getPatientList() {
    patientModel.filterByStateType(2);
  }

  void updatePatientList() {
    patientModel.patientList.forEach((element) {
      patientModel.editPatient(element);
      patientModel.setStateTypeId(2);
      patientModel.update();
    });
  }

  void addPatientStatus() {
    double hr;
    double pr;
    double ox;
    double su;
    double ur;
    double st;
    double bp;
    double tp;
    double itp;
    int d;

    patientModel.patientList.forEach((element) {
      hr = 85;
      pr = 80;
      ox = 90;
      su = 90;
      ur = 25;
      st = 25;
      bp = 90;
      tp = 38;
      itp = 38;
      d = 1;
      for (int i = 0; i < 10; i++) {
        statusModel.createStatus();
        statusModel.setNurseId(2);
        statusModel.setPatientId(element.userId);
        statusModel.setHeartRate(hr);
        statusModel.setPulseRate(pr);
        statusModel.setOxygen(ox);
        statusModel.setWeight(element.weight);
        statusModel.setSugar(su);
        statusModel.setUrine(ur);
        statusModel.setStool(st);
        statusModel.setBloodPressure(bp);
        statusModel.setTemperature(tp);
        statusModel.setIncubatorTemperature(itp);
        if (d > 9) {
          statusModel.setDate(DateTime.parse('2020-04-' + d.toString()));
        } else {
          statusModel.setDate(DateTime.parse('2020-04-0' + d.toString()));
        }
        statusModel.create();

        hr++;
        pr++;
        ox++;
        su++;
        ur++;
        st++;
        bp++;
        element.weight += 50;
        d += 1;
      }
    });
  }

  void getPatientLaboratory() {
    patientLaboratoryModel.readAll();
  }

  void addPatientLaboratory() {
    patientModel.patientList.forEach((element) {
      patientLaboratoryModel.createPatientLaboratory();
      patientLaboratoryModel.setPatientId(element.userId);
      patientLaboratoryModel.setLaboratoryId(8);
      patientLaboratoryModel.setResult('Results is ok');
      patientLaboratoryModel.setBillStatus('Pending');
      patientLaboratoryModel.create();
    });
  }

  void updatePatientLaboratory() {
    patientLaboratoryModel.patientLaboratoryList.forEach((element) {
      patientLaboratoryModel.editPatientLaboratory(element);
      patientLaboratoryModel.setBillStatus('Pending');
      patientLaboratoryModel.update();
    });
  }

  void getPatientXRay() {
    patientXRayModel.readAll();
  }

  void addPatientXRay() {
    patientModel.patientList.forEach((element) {
      patientXRayModel.createPatientXRay();
      patientXRayModel.setPatientId(element.userId);
      patientXRayModel.setXRayId(7);
      patientXRayModel.setComment('Results is ok');
      patientXRayModel.setBillStatus('Pending');
      patientXRayModel.create();
    });
  }

  void updatePatientXRay() {
    patientXRayModel.patientXRayList.forEach((element) {
      patientXRayModel.editPatientXRay(element);
      patientXRayModel.setBillStatus('Pending');
      patientXRayModel.update();
    });
  }

  void getPatientMedicineList() {
    patientMedicineDoctorModel.readAll();
  }

  void addPatientMedicine() {
    patientModel.patientList.forEach((element) {
      patientMedicineDoctorModel.createPatientMedicineDoctor();
      patientMedicineDoctorModel.setPatientId(element.userId);
      patientMedicineDoctorModel.setMedicineId(4);
      patientMedicineDoctorModel.setDoctorId(1);
      patientMedicineDoctorModel.setQuantity(1);
      patientMedicineDoctorModel.setBillStatus('Pending');
      patientMedicineDoctorModel.create();
    });
  }

  void updatePatientMedicine() {
    patientMedicineDoctorModel.patientMedicineDoctorList.forEach((element) {
      patientMedicineDoctorModel.editPatientMedicineDoctor(element);
      patientMedicineDoctorModel.setQuantity(1);
      patientMedicineDoctorModel.setBillStatus('Pending');
      patientMedicineDoctorModel.update();
    });
  }

  void getPatientConsumableList() {
    patientConsumableNurseModel.readAll();
  }

  void addPatientConsumable() {
    patientModel.patientList.forEach((element) {
      patientConsumableNurseModel.createPatientConsumableNurse();
      patientConsumableNurseModel.setPatientId(element.userId);
      patientConsumableNurseModel.setConsumableId(7);
      patientConsumableNurseModel.setNurseId(2);
      patientConsumableNurseModel.setQuantity(1);
      patientConsumableNurseModel.setBillStatus('Pending');
      patientConsumableNurseModel.create();
    });
  }

  void updatePatientConsumable() {
    patientConsumableNurseModel.patientConsumableNurseList.forEach((element) {
      patientConsumableNurseModel.editPatientConsumableNurse(element);
      patientConsumableNurseModel.setQuantity(1);
      patientConsumableNurseModel.setBillStatus('Pending');
      patientConsumableNurseModel.update();
    });
  }

  void getPatientExtra() {
    patientExtraModel.readAll();
  }

  void addPatientExtra() {
    patientModel.patientList.forEach((element) {
      patientExtraModel.createPatientExtra();
      patientExtraModel.setPatientId(element.userId);
      patientExtraModel.setExtraId(2);
      patientExtraModel.setBillStatus('Pending');
      patientExtraModel.create();
    });
  }

  void updatePatientExtra() {
    patientExtraModel.patientExtraList.forEach((element) {
      patientExtraModel.editPatientExtra(element);
      patientExtraModel.setBillStatus('Pending');
      patientExtraModel.update();
    });
  }
}
