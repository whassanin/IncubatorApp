import 'package:json_annotation/json_annotation.dart';

part 'bill.g.dart';

@JsonSerializable()
class Bill {
  int id;

  @JsonKey(name: 'date')
  DateTime createdDate;

  double paid;
  double dayCost;
  double consumable;
  double laboratory;
  double xRay;
  double lightRays;
  double medicine;
  double extra;
  double discount;
  int patientId;

  Bill(
    this.id,
    this.createdDate,
    this.paid,
    this.dayCost,
    this.consumable,
    this.laboratory,
    this.xRay,
    this.lightRays,
    this.medicine,
    this.extra,
    this.discount,
    this.patientId,
  );

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}
