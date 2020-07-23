import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consumable.g.dart';

@JsonSerializable()

class Consumable{

  int id;
  String name;
  double amount;

  @JsonKey(ignore: true)
  List<PatientConsumableNurse> patientConsumableNurseList = [];

  Consumable(this.id,this.name,this.amount);

  factory Consumable.fromJson(Map<String, dynamic> json) => _$ConsumableFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumableToJson(this);
}