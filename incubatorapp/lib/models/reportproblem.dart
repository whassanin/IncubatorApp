import 'package:json_annotation/json_annotation.dart';

part 'reportproblem.g.dart';

@JsonSerializable()
class ReportProblem{
  int id;
  String subject;
  String body;
  String mailTo;
  String mailFrom;
  String status;
  DateTime createdDate;

  ReportProblem(this.id,this.subject,this.body,this.mailTo,this.mailFrom,this.status,this.createdDate);

  factory ReportProblem.fromJson(Map<String, dynamic> json) => _$ReportProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ReportProblemToJson(this);
}