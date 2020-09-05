import 'package:incubatorapp/models/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statetype.g.dart';

@JsonSerializable()

class StateType {
  int id;
  String name;

  @JsonKey(ignore: true)
  List<Patient> patientList = [];

  StateType(this.id,this.name);

  factory StateType.fromJson(Map<String, dynamic> json) => _$StateTypeFromJson(json);

  Map<String, dynamic> toJson() => _$StateTypeToJson(this);
}
