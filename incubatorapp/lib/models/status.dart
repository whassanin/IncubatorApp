import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status{
  int id;
  double temperature;
  double oxygen;
  double weight;
  double pressure;
  double sugar;
  DateTime createdDate;

  Status(this.id,this.temperature,this.oxygen,this.weight,this.pressure,this.sugar,this.createdDate);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}