import 'package:json_annotation/json_annotation.dart';

part 'nurseshift.g.dart';

@JsonSerializable()
class NurseShift {
  int id;
  int nurseId;
  int shiftId;
  DateTime startDateTime;
  bool isSignedIn;
  DateTime endDateTime;
  bool isSignedOut;
  DateTime createdDate;
  DateTime changedDate;

  NurseShift(
    this.id,
    this.nurseId,
    this.shiftId,
    this.startDateTime,
    this.isSignedIn,
    this.endDateTime,
    this.isSignedOut,
    this.createdDate,
    this.changedDate,
  );

  factory NurseShift.fromJson(Map<String, dynamic> json) =>
      _$NurseShiftFromJson(json);

  Map<String, dynamic> toJson() => _$NurseShiftToJson(this);
}
