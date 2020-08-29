import 'package:json_annotation/json_annotation.dart';

part 'patientmedicinedoctor.g.dart';

@JsonSerializable()
class PatientMedicineDoctor {
  int id;
  int medicineId;
  int patientId;
  int doctorId;
  int quantity;
  String description;
  String status;
  DateTime date;
  DateTime createdDate;

  PatientMedicineDoctor(
    this.id,
    this.medicineId,
    this.patientId,
    this.doctorId,
    this.quantity,
    this.description,
    this.status,
    this.date,
    this.createdDate,
  );

  factory PatientMedicineDoctor.fromJson(Map<String, dynamic> json) =>
      _$PatientMedicineDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$PatientMedicineDoctorToJson(this);
}
