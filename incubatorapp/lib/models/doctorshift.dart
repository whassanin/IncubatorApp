import 'package:json_annotation/json_annotation.dart';

part 'doctorshift.g.dart';

@JsonSerializable()

class DoctorShift{
  int id;
  int doctorId;
  int shiftId;
  DateTime startDateTime;
  DateTime endDateTime;
  DateTime createdDate;

  DoctorShift(this.id,this.doctorId,this.shiftId,this.startDateTime,this.endDateTime,this.createdDate);

  factory DoctorShift.fromJson(Map<String, dynamic> json) => _$DoctorShiftFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorShiftToJson(this);
}