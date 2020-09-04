import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/creditcard.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patientextra.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  int userId;
  String motherName;
  String fatherName;
  bool gender;
  DateTime dateOfBirth;
  String address;
  double weight;
  String ssn;
  String state;
  DateTime createdDate;
  bool isOnLightRay;
  int conditionId;
  int incubatorId;

  @JsonKey(name: 'patientanalysis')
  List<PatientAnalysis> patientAnalysisList = [];

  @JsonKey(name: 'patientxray')
  List<PatientXRay> patientXRaysList = [];

  @JsonKey(name: 'patientmedicinedoctor')
  List<PatientMedicineDoctor> patientMedicineDoctorList = [];

  @JsonKey(name: 'patientconsumablenurse')
  List<PatientConsumableNurse> patientConsumableNurseList = [];

  @JsonKey(name: 'patientextra')
  List<PatientExtra> patientExtraList = [];

  @JsonKey(ignore: true)
  List<Status> statusList = [];

  @JsonKey(ignore: true)
  List<Bill> billList = [];

  @JsonKey(ignore: true)
  List<CreditCard> creditCardList = [];

  Patient(
    this.userId,
    this.motherName,
    this.fatherName,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.weight,
    this.ssn,
    this.state,
    this.isOnLightRay,
    this.createdDate,
    this.conditionId,
    this.incubatorId,
    this.patientAnalysisList,
    this.patientXRaysList,
    this.patientMedicineDoctorList,
    this.patientConsumableNurseList,
    this.patientExtraList,
  );

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
