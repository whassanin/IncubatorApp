import 'package:json_annotation/json_annotation.dart';

part 'creditcard.g.dart';

@JsonSerializable()

class CreditCard {
  int id;
  String holder;
  String number;
  int expireYear;
  int expireMonth;
  int patientId;
  DateTime createdDate;

  @JsonKey(ignore: true)
  int cvv;

  CreditCard(this.id,this.holder,this.number,this.expireMonth,this.expireYear,this.patientId,this.createdDate);

  factory CreditCard.fromJson(Map<String, dynamic> json) => _$CreditCardFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardToJson(this);
}
