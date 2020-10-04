
import 'package:json_annotation/json_annotation.dart';

part 'patientlaboratory.g.dart';

@JsonSerializable()

class PatientLaboratory{
  int id;
  int patientId;
  int laboratoryId;
  String result;
  DateTime createdDate;

  PatientLaboratory(this.id,this.patientId,this.laboratoryId,this.result,this.createdDate);

  factory PatientLaboratory.fromJson(Map<String, dynamic> json) => _$PatientLaboratoryFromJson(json);

  Map<String, dynamic> toJson() => _$PatientLaboratoryToJson(this);
}