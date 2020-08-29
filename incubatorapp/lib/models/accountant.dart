import 'package:json_annotation/json_annotation.dart';

part 'accountant.g.dart';

@JsonSerializable()
class Accountant {
  int userId;
  String firstName;
  String lastName;
  bool gender;
  DateTime dateOfBirth;
  DateTime createdDate;

  Accountant(
      this.userId,
      this.firstName,
      this.lastName,
      this.gender,
      this.dateOfBirth,
      this.createdDate,
      );

  factory Accountant.fromJson(Map<String, dynamic> json) => _$AccountantFromJson(json);

  Map<String, dynamic> toJson() => _$AccountantToJson(this);
}
