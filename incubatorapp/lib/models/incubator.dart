import 'package:incubatorapp/models/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incubator.g.dart';

@JsonSerializable()

class Incubator {
  int id;
  String companyName;

  @JsonKey(ignore: true)
  List<Patient> patientList = [];

  Incubator(this.id,this.companyName);

  factory Incubator.fromJson(Map<String, dynamic> json) => _$IncubatorFromJson(json);

  Map<String, dynamic> toJson() => _$IncubatorToJson(this);
}
