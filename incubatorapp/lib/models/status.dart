import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  int id;
  double heartRate;
  double pulseRate;
  double oxygen;
  double weight;
  double sugar;
  double urine;
  double stool;
  double bloodPressure;
  double temperature;
  double incubatorTemperature;
  DateTime createdDate;
  int patientId;
  int nurseId;

  Status(
    this.id,
    this.heartRate,
    this.pulseRate,
    this.oxygen,
    this.weight,
    this.sugar,
    this.urine,
    this.stool,
    this.bloodPressure,
    this.temperature,
    this.incubatorTemperature,
    this.createdDate,
    this.patientId,
    this.nurseId,
  );

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
