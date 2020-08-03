import 'package:incubatorapp/models/patientxray.dart';
import 'package:json_annotation/json_annotation.dart';

part 'xray.g.dart';

@JsonSerializable()
class XRay{
  int id;
  String name;
  double price;

  @JsonKey(ignore: true)
  List<PatientXRay> patientXRaysList = [];

  XRay(this.id,this.name,this.price);

  factory XRay.fromJson(Map<String, dynamic> json) => _$XRayFromJson(json);

  Map<String, dynamic> toJson() => _$XRayToJson(this);

}