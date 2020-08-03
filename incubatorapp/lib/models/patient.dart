import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:incubatorapp/models/patientphone.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  int id;
  String motherName;
  String fatherName;
  bool gender;
  DateTime dateOfBirth;
  String address;
  double weight;
  String ssn;
  bool isOut;
  String username;
  String password;
  DateTime createdDate;
  int conditionId;
  int incubatorId;
  PatientPhone patientPhone;

  @JsonKey(ignore: true)
  List<PatientAnalysis> patientAnalysisList = [];

  @JsonKey(ignore: true)
  List<Bill> billList = [];

  @JsonKey(ignore: true)
  List<PatientXRay> patientXRays = [];

  @JsonKey(ignore: true)
  List<PatientMedicineDoctor> patientMedicineDoctorList = [];

  @JsonKey(ignore: true)
  List<PatientConsumableNurse> patientConsumableNurseList = [];

  @JsonKey(ignore: true)
  List<Status> statusList = [];

  Patient(
    this.id,
    this.motherName,
    this.fatherName,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.weight,
    this.ssn,
    this.isOut,
    this.username,
    this.password,
    this.createdDate,
    this.conditionId,
    this.incubatorId,
    this.patientPhone,
  );

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
