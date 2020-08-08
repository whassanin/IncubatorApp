import 'package:incubatorapp/models/doctorshift.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  int id;
  String firstName;
  String lastName;
  bool gender;
  DateTime dateOfBirth;
  String username;
  String password;
  DateTime createdDate;

  @JsonKey(ignore: true)
  List<PatientMedicineDoctor> patientMedicineDoctorList = [];

  @JsonKey(ignore: true)
  List<DoctorShift> doctorShiftList = [];

  Doctor(
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.username,
    this.password,
    this.createdDate,
  );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
