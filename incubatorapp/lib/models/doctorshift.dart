import 'package:json_annotation/json_annotation.dart';

part 'doctorshift.g.dart';

@JsonSerializable()
class DoctorShift {
  int id;
  int doctorId;
  int shiftId;
  DateTime startDateTime;
  bool isSignedIn;
  DateTime endDateTime;
  bool isSignedOut;
  DateTime createdDate;
  DateTime changedDate;

  DoctorShift(
    this.id,
    this.doctorId,
    this.shiftId,
    this.startDateTime,
    this.isSignedIn,
    this.endDateTime,
    this.isSignedOut,
    this.createdDate,
    this.changedDate,
  );

  factory DoctorShift.fromJson(Map<String, dynamic> json) =>
      _$DoctorShiftFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorShiftToJson(this);
}
