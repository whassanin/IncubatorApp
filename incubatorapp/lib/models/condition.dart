import 'package:json_annotation/json_annotation.dart';

part 'condition.g.dart';

@JsonSerializable()
class Condition {
  int id;
  String name;
  double price;

  Condition(this.id, this.name, this.price);

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}
