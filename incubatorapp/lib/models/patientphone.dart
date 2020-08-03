
import 'package:json_annotation/json_annotation.dart';

part 'patientphone.g.dart';

@JsonSerializable()

class PatientPhone{
  int id;
  String phone;
  int patientId;

  PatientPhone(this.id,this.phone,this.patientId);

  factory PatientPhone.fromJson(Map<String, dynamic> json) => _$PatientPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PatientPhoneToJson(this);
}