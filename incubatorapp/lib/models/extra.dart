import 'package:incubatorapp/models/patientextra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extra.g.dart';

@JsonSerializable()
class Extra {
  int id;
  String name;
  double price;

  @JsonKey(ignore: true)
  List<PatientExtra> patientExtraList = [];

  Extra(this.id,this.name,this.price);

  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraToJson(this);
}