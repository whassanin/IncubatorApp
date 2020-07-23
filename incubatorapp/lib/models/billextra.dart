
import 'package:json_annotation/json_annotation.dart';

part 'billextra.g.dart';

@JsonSerializable()

class BillExtra {
  int id;
  String name;
  double cost;

  BillExtra(this.id,this.name,this.cost);

  factory BillExtra.fromJson(Map<String, dynamic> json) => _$BillExtraFromJson(json);

  Map<String, dynamic> toJson() => _$BillExtraToJson(this);
}
