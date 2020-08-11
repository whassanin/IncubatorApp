import 'package:incubatorapp/models/doctorshift.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift {
  int id;
  String name;
  int startTime;
  bool isStarTimePM;
  int endTime;
  bool isEndTimePM;

  @JsonKey(ignore: true)
  List<DoctorShift> doctorShiftList = [];

  @JsonKey(ignore: true)
  List<NurseShift> nurseShift = [];

  Shift(
    this.id,
    this.name,
    this.startTime,
    this.isStarTimePM,
    this.endTime,
    this.isEndTimePM,
  );

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
