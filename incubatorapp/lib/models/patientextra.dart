
import 'package:json_annotation/json_annotation.dart';

part 'patientextra.g.dart';

@JsonSerializable()

class PatientExtra{
  int id;
  int patientId;
  int extraId;
  DateTime createdDate;

  PatientExtra(this.id,this.patientId,this.extraId,this.createdDate);

  factory PatientExtra.fromJson(Map<String, dynamic> json) => _$PatientExtraFromJson(json);

  Map<String, dynamic> toJson() => _$PatientExtraToJson(this);
}