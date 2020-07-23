
import 'package:json_annotation/json_annotation.dart';

part 'nurseshift.g.dart';

@JsonSerializable()

class NurseShift{

  int id;
  int nurseId;
  int shiftId;

  NurseShift(this.id,this.nurseId,this.shiftId);


  factory NurseShift.fromJson(Map<String, dynamic> json) => _$NurseShiftFromJson(json);

  Map<String, dynamic> toJson() => _$NurseShiftToJson(this);
}