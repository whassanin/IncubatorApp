import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consumable.g.dart';

@JsonSerializable()

class Consumable{

  int id;
  String name;
  double price;
  double amount;

  @JsonKey(ignore: true)
  List<PatientConsumableNurse> patientConsumableNurseList = [];

  Consumable(this.id,this.name,this.amount,this.price);

  factory Consumable.fromJson(Map<String, dynamic> json) => _$ConsumableFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumableToJson(this);
}