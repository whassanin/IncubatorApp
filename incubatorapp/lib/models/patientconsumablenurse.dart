
import 'package:json_annotation/json_annotation.dart';

part 'patientconsumablenurse.g.dart';

@JsonSerializable()
class PatientConsumableNurse{
  int id;
  int consumableId;
  int patientId;
  int nurseId;
  int quantity;
  DateTime createDate;

  PatientConsumableNurse(this.id,this.consumableId,this.patientId,this.nurseId,this.quantity,this.createDate);

  factory PatientConsumableNurse.fromJson(Map<String, dynamic> json) => _$PatientConsumableNurseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientConsumableNurseToJson(this);
}