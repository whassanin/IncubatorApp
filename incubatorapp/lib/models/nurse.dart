import 'package:incubatorapp/models/nurseshift.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nurse.g.dart';

@JsonSerializable()
class Nurse {
  int id;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String username;
  String password;
  DateTime createdDate;

  @JsonKey(ignore: true)
  List<PatientConsumableNurse> patientConsumableNurseList = [];

  @JsonKey(ignore: true)
  List<Status> statusList = [];

  @JsonKey(ignore: true)
  List<NurseShift> nurseShiftList = [];

  Nurse(
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.username,
    this.password,
    this.createdDate,
  );

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);

  Map<String, dynamic> toJson() => _$NurseToJson(this);
}
