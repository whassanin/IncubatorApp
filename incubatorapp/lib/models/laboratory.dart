import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laboratory.g.dart';

@JsonSerializable()

class Laboratory {
  int id;
  String name;
  double price;

  @JsonKey(ignore: true)
  List<PatientLaboratory> patientLaboratoryList = [];

  Laboratory(this.id,this.name,this.price);

  factory Laboratory.fromJson(Map<String, dynamic> json) => _$LaboratoryFromJson(json);

  Map<String, dynamic> toJson() => _$LaboratoryToJson(this);
}
