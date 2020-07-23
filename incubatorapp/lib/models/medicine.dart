import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicine.g.dart';

@JsonSerializable()

class Medicine {
  int id;
  String name;
  double amount;

  @JsonKey(ignore: true)
  List<PatientMedicineDoctor> patientMedicineDoctor = [];

  Medicine(this.id,this.name,this.amount);

  factory Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}