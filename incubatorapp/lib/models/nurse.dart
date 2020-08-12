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
  bool gender;
  DateTime dateOfBirth;
  DateTime createdDate;
  int userId;

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
    this.gender,
    this.dateOfBirth,
    this.createdDate,
    this.userId,
  );

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);

  Map<String, dynamic> toJson() => _$NurseToJson(this);
}
