import 'package:incubatorapp/models/billextra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill.g.dart';

@JsonSerializable()
class Bill {
  int id;
  DateTime createdDate;
  double paid;
  double dayCost;
  double staying;
  double incubatorClean;
  double consumable;
  double analysis;
  double xRay;
  double lightRays;
  double medicine;
  int patientId;

  @JsonKey(name: 'billExtra')
  List<BillExtra> billExtraList = [];

  Bill(
    this.id,
    this.createdDate,
    this.paid,
    this.dayCost,
    this.staying,
    this.incubatorClean,
    this.consumable,
    this.analysis,
    this.xRay,
    this.lightRays,
    this.medicine,
    this.patientId,
    this.billExtraList,
  );

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}
