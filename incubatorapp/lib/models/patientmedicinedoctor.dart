
import 'package:json_annotation/json_annotation.dart';

part 'patientmedicinedoctor.g.dart';

@JsonSerializable()

class PatientMedicineDoctor{
  int id;
  int consumableId;
  int patientId;
  int doctorId;
  int quantity;
  DateTime createDate;

  PatientMedicineDoctor(this.id,this.consumableId,this.patientId,this.doctorId,this.quantity,this.createDate);

  factory PatientMedicineDoctor.fromJson(Map<String, dynamic> json) => _$PatientMedicineDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$PatientMedicineDoctorToJson(this);
}