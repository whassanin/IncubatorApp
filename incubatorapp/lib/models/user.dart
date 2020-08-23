import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String userType;
  String email;
  String password;
  String provider;
  String phone;
  DateTime createdDate;

  User(this.id,this.email,this.password,this.userType,this.provider,this.phone,this.createdDate);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}