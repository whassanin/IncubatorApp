import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String userType;
  String username;
  String password;
  DateTime createdDate;

  User(this.id,this.username,this.password,this.userType,this.createdDate);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}