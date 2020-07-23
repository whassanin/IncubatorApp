import 'package:incubatorapp/models/doctorshift.dart';
import 'package:incubatorapp/models/nurseshift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift{
  int id;
  DateTime startDate;
  DateTime endDate;

  @JsonKey(ignore: true)
  List<DoctorShift> doctorShiftList = [];

  @JsonKey(ignore: true)
  List<NurseShift> nurseShift = [];

  Shift(this.id,this.startDate,this.endDate);

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}