import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
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
  int conditionId;
  int incubatorId;

  @JsonKey(name: 'status')
  List<Status> statusList = [];

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
    this.createdDate,
    this.conditionId,
    this.incubatorId,
    this.statusList,
  );

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
