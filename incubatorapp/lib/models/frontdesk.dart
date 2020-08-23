import 'package:json_annotation/json_annotation.dart';

part 'frontdesk.g.dart';

@JsonSerializable()
class FrontDesk {
  int userId;
  String firstName;
  String lastName;
  bool gender;
  DateTime dateOfBirth;
  DateTime createdDate;

  FrontDesk(
      this.userId,
      this.firstName,
      this.lastName,
      this.gender,
      this.dateOfBirth,
      this.createdDate,
      );

  factory FrontDesk.fromJson(Map<String, dynamic> json) => _$FrontDeskFromJson(json);

  Map<String, dynamic> toJson() => _$FrontDeskToJson(this);
}
