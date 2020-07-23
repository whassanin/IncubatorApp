import 'package:json_annotation/json_annotation.dart';

part 'patientxray.g.dart';

@JsonSerializable()
class PatientXRay{
  int id;
  int patientId;
  int xRayId;
  DateTime createdDate;
  String comment;

  PatientXRay(this.id,this.patientId,this.xRayId,this.comment,this.createdDate,);

  factory PatientXRay.fromJson(Map<String, dynamic> json) => _$PatientXRayFromJson(json);

  Map<String, dynamic> toJson() => _$PatientXRayToJson(this);
}